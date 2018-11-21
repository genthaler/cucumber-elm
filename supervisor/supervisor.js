#!/usr/bin/env node
const shell = require('shelljs')
const fs = require('fs')
const path = require('path')
const glob = require("glob")
const R = require('rambda')
// const proxyquire = require('proxyquire')
const compiler = require('node-elm-compiler')
const compile = compiler.compile
const compileToString = compiler.compileToString
const supervisor = require(path.resolve(__dirname, 'supervisorWorker.js'))
// const supervisor = require('cucumber-elm-supervisor')
const requireFromString = require('require-from-string')

const supervisorWorker = supervisor.Elm.Supervisor.Main.init({
  flags: {
    argv: process.argv
  }
})

const send = supervisorWorker.ports.rawResponse.send

supervisorWorker.ports.request.subscribe(
  cmd => {
    switch (cmd.command) {
      case "Echo":
        shell.echo(cmd.message)
        break

      case "FileRead":
        send(shell.cat(path.resolve.apply(null, cmd.paths)))
        break

      case "ExportedInterfaces":
        const elmiToJsonPath = require("elmi-to-json").paths["elmi-to-json"]
        send(shell.exec(elmiToJsonPath, { cwd: "cucumber" }))
        break

      case "FileWrite":
        send(shell.echo(cmd.fileContent).to(path.resolve.apply(null, cmd.paths)))
        break

      case "FileList":
        glob(cmd.glob, { cwd: path.resolve.apply(null, cmd.cwd) }, (er, files) => {
          if (er == null) {
            send({
              code: 0,
              fileList: files
            })
          } else {
            send({
              code: 1,
              stderr: er.message
            })
          }
        })
        break

      case "ModuleDirectory":
        send({
          code: 0,
          fileList: [__dirname]
        })
        break

      case "Copy":
        console.log("Copy")
        send(shell.cp('-rf', path.resolve.apply(null, cmd.from), path.resolve.apply(null, cmd.to)))
        break

      case "Shell":
        send(shell.exec(cmd.cmd))
        break

      case "Require":
        send(shell.echo(cmd.message))
        break

      case "Compile":
        // var result = compiler.compileToStringSync(prependFixturesDir("Parent.elm"), opts)
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
          }))
        break

      case "CucumberBoot":
        (glueFunctionName, runnerSource) => {
          let runnerWorker = requireFromString(runnerSource).Runner.worker()
          supervisorWorker.ports.cucumberRunRequest.subscribe(runnerWorker.ports.cucumberRunRequest.send)
          supervisorWorker.ports.cucumberRunResponse.subscribe(runnerWorker.ports.cucumberRunResponse.send)
          send({
            exitCode: 0
          })
        }
        break

      case "Exit":
        shell.echo(cmd.message)
        shell.exit(cmd.exitCode)
        break

      default:
        send({
          exitCode: 1,
          stderr: cmd.command + " sent on the wrong port"
        })
        break

    }

  })


// let runner = require(runnerJs)
// proxyquire.noPreserveCache()
// let runnerWorker = proxyquire(resolvedRunnerLocation).Runner.worker()
// proxyquire.preserveCache()
