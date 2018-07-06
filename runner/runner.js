var readline = require('readline');
var elm = require('./calc');
var runner = elm.Calc.worker();
var rl = readline.createInterface({input: process.stdin, output: process.stdout});
runner.ports.output.subscribe(function(s) { rl.output.write(s+'\n'); });
runner.ports.end.subscribe(function(n) { process.exit(n); });
rl.on('line', function(cmd) { runner.ports.input.send(cmd); });
rl.on('close', function() { runner.ports.close.send([]); });
