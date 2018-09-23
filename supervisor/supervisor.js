#!/usr/bin/env node

const shell = require('shelljs')
const fs = require('fs')
const path = require('path')
const glob = require("glob")
const R = require('rambda')
// const proxyquire = require('proxyquire')
const compiler = require('node-elm-compiler')
// const supervisor = require('cucumber-elm-supervisor');
const supervisor = require('supervisorWorker.js');
const requireFromString = require('require-from-string');

const supervisorWorker = supervisor.SupervisorWorker.init({
  flags: {
    argv: process.argv
  }
})

const compile = compiler.compile;
const compileToString = compiler.compileToString;
const XMLHttpRequest = require('xhr2')

supervisorWorker.ports.print.subscribe(message => console.log(message))
supervisorWorker.ports.printAndExitFailure.subscribe(message => {
  console.log(message)
  process.exit(1)
})
supervisorWorker.ports.printAndExitSuccess.subscribe(message => {
  console.log(message)
  process.exit(0)
})

/*
 * Wire up fileReadRequest/Response
 */
supervisorWorker.ports.fileReadRequest.subscribe(
  R.pipe(
    (fileName) => shell.cat(fileName).stdout,
    supervisorWorker.ports.fileReadResponse.send
  )
)

/*
 * Wire up echoRequest
 */
supervisorWorker.ports.echoRequest.subscribe(shell.echo)

/*
 * Wire up fileWriteRequest/Response
 */
supervisorWorker.ports.fileWriteRequest.subscribe(
  R.pipe(
    (fileName, fileContent) => shell.echo(fileContent).to(path.resolve(fileName)).code,
    supervisorWorker.ports.fileWriteResponse.send
  )
)

/*
 * Wire up fileGlobResolveRequest/Response
 */
supervisorWorker.ports.fileGlobResolveRequest.subscribe(
  (fileGlob) => glob(fileGlob, {}, (er, files) => {
    console.log(er)
    supervisorWorker.ports.fileGlobResolveResponse.send(files)
  })
)

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

supervisorWorker.ports.end.subscribe(process.exit)
