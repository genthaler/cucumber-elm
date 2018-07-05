load('./windowTimers.js');
load('./calc.js');
var window = this;
var timerLoop = makeWindowTimer(window, java.lang.Thread.sleep);
var ended = false;
spawn(function () {
    while (!ended) {
        timerLoop();
    }
});
var runner = Elm.Calc.worker();
runner.ports.output.subscribe(function(s) { print(s); });
runner.ports.end.subscribe(function(n) { java.lang.System.exit(n); });
var stdin = new java.io.BufferedReader( new java.io.InputStreamReader(java.lang.System['in']) );
var aLine;
while (aLine = stdin.readLine()) {
    var trimmed = aLine.trim();
    runner.ports.input.send('' + trimmed);
}
runner.ports.close.send({});
