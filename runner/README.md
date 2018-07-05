# elm-worker-runner-example
Minimal code for node and rhino for running an elm worker

More info: https://medium.com/@prozacchiwawa/the-im-stupid-elm-language-nugget-10-3a9c119ed6f9#.vj07jba42

To try it out:

    elm make --output calc.js Calc.elm
    node runelm.js
    
And type some numbers and operators:

<pre>
<b>3</b>
3
<b>7</b>
7 3
<b>10</b>
10 7 3
<b>+</b>
17 3
<b>-</b>
14
<b>^D</b>
14
</pre>
