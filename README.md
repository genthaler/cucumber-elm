# Cucumber in Elm

## Testing:

The following assumes node and npm are installed.

```
npm install -g elm@0.17.1
elm-make TestRunner.elm --output TestRunner.js --yes
node TestRunner.js
```

## To do

- [x] Gherkin grammar as ADT
- [ ] Test runner
- [ ] Plain-text Gherkin parser
- [ ] Full set of tests from the canonical Gherkin project
