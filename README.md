# Cucumber in Elm

## Testing:

The following assumes node and npm are installed.

```
npm install -g elm@0.17.1
elm-make TestRunner.elm --output TestRunner.js --yes
node TestRunner.js
```

## To do

- [x] Basic Gherkin grammar as ADT
- [ ] Test runner
- [ ] Support tags #1
- [ ] Plain-text Gherkin parser #2
- [ ] Support Gherkin i18n #3
- [ ] Full set of tests from the canonical Gherkin project #4
- [ ] Pretty print Gherkin ADT #5
- [ ] Build and test using i18n and test data directly from the canonical Gherkin project #6

[![Build Status](https://travis-ci.org/genthaler/cucumber-elm.svg?branch=master)](https://travis-ci.org/genthaler/cucumber-elm)
