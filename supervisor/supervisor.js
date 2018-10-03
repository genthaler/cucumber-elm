#!/usr/bin/env node

const shell = require('shelljs')
const fs = require('fs')
const path = require('path')
const glob = require("glob")
const R = require('rambda')
// const proxyquire = require('proxyquire')
const compiler = require('node-elm-compiler')
// const supervisor = require('cucumber-elm-supervisor');
const supervisor = require('./supervisorWorker.js');
const requireFromString = require('require-from-string');

const supervisorWorker = supervisor.Elm.Supervisor.Main.init({
  flags: {
    argv: process.argv
  }
})

const compile = compiler.compile;
const compileToString = compiler.compileToString;

const send = supervisorWorker.ports.response.send;

supervisorWorker.ports.request.subscribe(
  cmd => {
    switch (cmd.command) {
      case "Echo":
        send(shell.echo(cmd.message));
        break;

      case "FileRead":
        send(shell.cat(cmd.fileName));
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

      case "Shell":
        send(shell.exec(cmd.cmd));
        break;

      case "Require":
        send(shell.echo(cmd.message));
        break;

      case "CucumberBoot":
        send(shell.echo(cmd.message));
        break;

      case "Cucumber":
        send(shell.echo(cmd.message));
        break;

      case "Copy":
        send(shell.cp('-rf', path.resolve(cmd.source), path.resolve(cmd.destination)));
        break;

      case "Compile":
        compiler.compileToString(path.resolve(source), {
            yes: true,
            verbose: true,
            cwd: path.dirname(path.resolve(source)),
            output: '.js'
          })
          .then((result) => supervisorWorker.ports.compileResponse.send({
            result: result,
            error: '',
            success: true
          }))
          .catch((error) => supervisorWorker.ports.compileResponse.send({
            result: '',
            error: error,
            success: false
          }));
        break;

      case "Exit":
        send(shell.exit(cmd.exitCode));
        break;
    }
  });


// var result = compiler.compileToStringSync(prependFixturesDir("Parent.elm"), opts);

supervisorWorker.ports.compileRequest.subscribe(
  (source) => {
    compiler.compileToString(path.resolve(source), {
        yes: true,
        verbose: true,
        cwd: path.dirname(path.resolve(source)),
        output: '.js'
      })
      .then((result) => supervisorWorker.ports.compileResponse.send({
        result: result,
        error: '',
        success: true
      }))
      .catch((error) => supervisorWorker.ports.compileResponse.send({
        result: '',
        error: error,
        success: false
      }))
  }
)

/* 
 * - compile & run Runner JavaScript
 * - wire up the supervisor to the Runner
 * - let the supervisor know that the Runner is ready to accept requests to run features
 */
supervisorWorker.ports.cucumberBootRequest.subscribe(
  (glueFunctionName, runnerSource) => {
    let runnerWorker = requireFromString(runnerSource).Runner.worker()
    supervisorWorker.ports.cucumberRunRequest.subscribe(runnerWorker.ports.cucumberRunRequest.send)
    supervisorWorker.ports.cucumberRunResponse.subscribe(runnerWorker.ports.cucumberRunResponse.send)
    supervisorWorker.ports.cucumberBootResponse.send(true)
  })

// let runner = require(runnerJs);
// proxyquire.noPreserveCache()
// let runnerWorker = proxyquire(resolvedRunnerLocation).Runner.worker()
// proxyquire.preserveCache()
