const shell = require('shelljs')
const fs = require('fs')
const path = require('path')
const glob = require("glob")
const R = require('rambda')
// const proxyquire = require('proxyquire')
const compiler = require('node-elm-compiler')
const supervisor = require('cucumber-elm-supervisor');
const requireFromString = require('require-from-string');

const supervisorWorker = supervisor.SupervisorWorker.worker(process.argv)
const compile = compiler.compile;
const compileToString = compiler.compileToString;


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
  async (glueFunctionName, runnerLocation) => {
    console.log('glueFunctionName: ' + glueFunctionName)
    console.log('runnerLocation: ' + runnerLocation)
    let resolvedRunnerSource = path.resolve('../runner')
    let resolvedRunnerDestination = path.resolve(runnerLocation)
    shell.cp('-rf', resolvedRunnerSource, resolvedRunnerDestination)
    shell.pushd(resolvedRunnerDestination)
    let runnerSource = path.resolve('src', 'Runner.elm')
    shell.sed(/\( \"\", \[\] \)/, glueFunctionName, runnerSource)
    // compile(runnerSource)

    let runnerJs = await compileToString([runnerSource], {
      yes: true
    })

    let runner = requireFromString(runnerJs)
    // let runner = require(runnerJs);
    let runnerWorker = runner.Runner.worker()
    // proxyquire.noPreserveCache()
    // let runnerWorker = proxyquire(resolvedRunnerLocation).Runner.worker()
    supervisorWorker.ports.cucumberRunRequest.subscribe(runnerWorker.ports.cucumberRunRequest.send)
    supervisorWorker.ports.cucumberRunResponse.subscribe(runnerWorker.ports.cucumberRunResponse.send)
    supervisorWorker.ports.cucumberBootResponse.send(true)
  })

supervisorWorker.ports.end.subscribe(process.exit)
