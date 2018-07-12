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
var shellExecute = function (cmd) {
  // 
};
var elmCompile = function (folderName) {
  // 
};

var end = function (exitCode) {
  process.exit(exitCode);
}

var supervisorWorkerElm = require('./SupervisorWorker');
var supervisorWorker = supervisorWorkerElm.SupervisorWorker.worker(process.argv);

supervisorWorker.ports.end.subscribe(end);

var runner = require('../runner/Runner');
var runnerWorker = runner.Runner.worker();

supervisorWorker.ports.shellRequest.subscribe(supervisorWorker.ports.shellResponse.send);
supervisorWorker.ports.fileReadRequest.subscribe(supervisorWorker.ports.fileReadResponse.send);

supervisorWorker.ports.cucumberRequest.subscribe(runnerWorker.ports.cucumberRequest.send);
supervisorWorker.ports.cucumberResponse.subscribe(runnerWorker.ports.cucumberResponse.send);
