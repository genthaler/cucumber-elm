#!/usr/bin/env node

const shell = require('shelljs')
const fs = require('fs')
const path = require('path')
const glob = require("glob")
const R = require('rambda')
// const proxyquire = require('proxyquire')
const elmi = require('node-elm-interface-to-json');
const compiler = require('node-elm-compiler')
const compile = compiler.compile;
const compileToString = compiler.compileToString;
const supervisor = require('./supervisorWorker.js');
// const supervisor = require('cucumber-elm-supervisor');
const requireFromString = require('require-from-string');


const supervisorWorker = supervisor.Elm.Supervisor.Main.init({
  flags: {
    argv: process.argv
  }
})

const send = supervisorWorker.ports.rawResponse.send;

supervisorWorker.ports.request.subscribe(
  cmd => {
    switch (cmd.command) {
      case "Echo":
        send(shell.echo(cmd.message));
        break;

      case "FileRead":
        send(shell.cat(cmd.fileName));
        break;

      case "ExportedInterfaces":
        send(shell.exec('elmi-to-json'));
        break;

      case "FileWrite":
        send(shell.echo(cmd.fileContent).to(path.resolve(cmd.fileName)));
        break;

      case "FileList":
        glob(cmd.glob, {}, (er, files) => {
          if (er == null) {
            send({
              code: 0,
              fileList: files
            });
          } else {
            send({
              code: 1,
              stderr: er.message
            });
          }
        });
        break;

      case "Copy":
        send(shell.cp('-rf', path.resolve(cmd.source), path.resolve(cmd.destination)));
        break;

      case "Shell":
        send(shell.exec(cmd.cmd));
        break;

      case "Require":
        send(shell.echo(cmd.message));
        break;

      case "Compile":
        // var result = compiler.compileToStringSync(prependFixturesDir("Parent.elm"), opts);
        compiler.compileToString(path.resolve(source), {
            yes: true,
            verbose: true,
            cwd: path.dirname(path.resolve(source)),
            output: '.js'
          })
          .then((result) => send({
            result: result,
            error: '',
            success: true
          }))
          .catch((error) => send({
            result: '',
            error: error,
            success: false
          }));
        break;

      case "CucumberBoot":
        (glueFunctionName, runnerSource) => {
          let runnerWorker = requireFromString(runnerSource).Runner.worker();
          supervisorWorker.ports.cucumberRunRequest.subscribe(runnerWorker.ports.cucumberRunRequest.send);
          supervisorWorker.ports.cucumberRunResponse.subscribe(runnerWorker.ports.cucumberRunResponse.send);
          send({
            exitCode: 0
          });
        };
        break;

      case "Exit":
        send(shell.exit(cmd.exitCode));
        break;

      default:
        send({
          exitCode: 1,
          stderr: cmd.command + " sent on the wrong port"
        });
        break;

    }

  });


// let runner = require(runnerJs);
// proxyquire.noPreserveCache()
// let runnerWorker = proxyquire(resolvedRunnerLocation).Runner.worker()
// proxyquire.preserveCache()
