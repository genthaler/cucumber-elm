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

/*
 * Wire up request
 */
supervisorWorker.ports.request.subscribe(cmd => {
  switch (cmd.command) {
    case "Echo":
      shell.echo(cmd.message)
      break;

    case "FileRead":
      supervisorWorker.ports.response.send({ fileContent: shell.cat(cmd.fileName).stdout });
      break;

    case "FileWrite":
      supervisorWorker.ports.response.send({ exitCode: shell.echo(cmd.fileContent).to(path.resolve(cmd.fileName)).code });
      break;

    case "FileList":
      glob(cmd.glob, {}, (er, files) => {
        if (er == null) {
          supervisorWorker.ports.response.send({ fileList: files });
        } else {
          supervisorWorker.ports.response.send({ error: er.message });
        }
      });
      break;

    case "Shell":
      supervisorWorker.ports.response.send({ exitCode: shell.echo(cmd.fileContent).to(path.resolve(cmd.fileName)).code });
      break;

    case "Require":
      shell.echo(cmd.message)
      break;

    case "CucumberBoot":
      shell.echo(cmd.message)
      break;

    case "Cucumber":
      shell.echo(cmd.message)
      break;
      
    case "End":
      process.exit(cmd.exitCode);
      break;
  }
})

supervisorWorker.ports.shellRequest.subscribe(
  R.pipe(
    shell.exec,
    supervisorWorker.ports.shellResponse.send
  )
)

supervisorWorker.ports.copyRequest.subscribe(
  (source, destination) => {
    R.pipe(
      shell.cp('-rf', path.resolve(source), path.resolve(destination)).code,
      supervisorWorker.ports.copyResponse.send
    )
  }
)

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

