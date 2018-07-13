var shell = require('shelljs');

const compose = (...fns) =>
  fns.reduce((f, g) => (...args) => f(g(...args)));

var fileRead = function (fileName) {
  // 
};
var fileWrite = function (fileName, fileContent) {
  // 
};
var fileGlobResolve = function (fileGlob) {
  // 
};
var shell = function (cmd) {
  // 
};
var shell = function (cmd) {
  // 
};
var elmCompile = function (folderName) {
  // 
};

var supervisorWorkerElm = require('./SupervisorWorker');
var supervisorWorker = supervisorWorkerElm.SupervisorWorker.worker(process.argv);

supervisorWorker.ports.end.subscribe(process.exit);

var runner = require('../runner/Runner');
var runnerWorker = runner.Runner.worker();

supervisorWorker.ports.shellRequest.subscribe(compose(supervisorWorker.ports.shellResponse.send, shell));
supervisorWorker.ports.fileReadRequest.subscribe(compose(supervisorWorker.ports.fileReadResponse.send, fileRead));
supervisorWorker.ports.fileWriteRequest.subscribe(compose(supervisorWorker.ports.fileWriteResponse.send, fileWrite));
supervisorWorker.ports.fileGlobResolveRequest.subscribe(compose(supervisorWorker.ports.fileGlobResolveResponse.send, fileGlobResolve));
supervisorWorker.ports.fileReadRequest.subscribe(compose(supervisorWorker.ports.fileReadResponse.send, fileRead));
supervisorWorker.ports.fileReadRequest.subscribe(compose(supervisorWorker.ports.fileReadResponse.send, fileRead));

supervisorWorker.ports.cucumberRequest.subscribe(runnerWorker.ports.cucumberRequest.send);
supervisorWorker.ports.cucumberResponse.subscribe(runnerWorker.ports.cucumberResponse.send);
