const shell = require('shelljs')
const fs = require('fs')
const path = require('path')
const glob = require("glob")
const R = require('rambda')
const proxyquire = require('proxyquire').noPreserveCache()
const compile = require('node-elm-compiler').compile;
const compileToString = require('node-elm-compiler').compileToString;

var supervisorWorker = require('./SupervisorWorker').SupervisorWorker.worker(process.argv)

supervisorWorker.ports.fileReadRequest.subscribe(
  R.pipe(
    (fileName) => shell.cat(fileName).stdout,
    supervisorWorker.ports.fileReadResponse.send
  )
)

supervisorWorker.ports.echoRequest.subscribe(shell.echo)

supervisorWorker.ports.fileWriteRequest.subscribe(
  R.pipe(
    (fileName, fileContent) => shell.echo(fileContent).to(path.resolve(fileName)).code,
    supervisorWorker.ports.fileWriteResponse.send
  )
)

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

/* - copy the runner source to a temporary directory
 * - paste in the name of the glueFunction into Runner.elm
 * - compile
 * - wire up the supervisor to the Runner
 * - let the supervisor know that the Runner is ready to accept requests to run features
 */
supervisorWorker.ports.cucumberBootRequest.subscribe(
  (glueFunctionName, runnerLocation) => {
    const resolvedRunnerSource = path.resolve('../runner')
    const resolvedRunnerDestination = path.resolve(runnerLocation)
    shell.cp('-rf', resolvedRunnerSource, resolvedRunnerDestination)
    shell.pushd(resolvedRunnerDestination)
    const runnerSource = path.resolve('src', 'Runner.elm')
    compile('runnerSource')

    const runnerWorker = proxyquire(resolvedRunnerLocation).Runner.worker()
    supervisorWorker.ports.cucumberRunRequest.subscribe(runnerWorker.ports.cucumberRunRequest.send)
    supervisorWorker.ports.cucumberRunResponse.subscribe(runnerWorker.ports.cucumberRunResponse.send)
    supervisorWorker.ports.cucumberBootResponse.send(true)
  })

supervisorWorker.ports.end.subscribe(process.exit)
