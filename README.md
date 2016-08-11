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
- [ ] Support tags [#1](genthaler/cucumber-elm#1)
- [ ] Plain-text Gherkin parser [#2](genthaler/cucumber-elm#2)
- [ ] Support Gherkin i18n [#3](genthaler/cucumber-elm#3)
- [ ] Full set of tests from the canonical Gherkin project [#4](genthaler/cucumber-elm#4)
- [ ] Pretty print Gherkin ADT [#5](genthaler/cucumber-elm#5)
- [ ] Build and test using i18n and test data directly from the canonical Gherkin project [#6](genthaler/cucumber-elm#6)

[![Travis-CI build Status](https://travis-ci.org/genthaler/cucumber-elm.svg?branch=master)](https://travis-ci.org/genthaler/cucumber-elm)

[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/tn79mfap9v0fg2qb/branch/master?svg=true)](https://ci.appveyor.com/project/genthaler/cucumber-elm/branch/master)

[![Dependency CI Status](https://dependencyci.com/github/genthaler/cucumber-elm/badge?style=flat)](https://dependencyci.com/github/genthaler/cucumber-elm/badge?style=flat)

[![](https://raw.githubusercontent.com/ZenHubIO/support/master/zenhub-badge.png)](https://zenhub.com)
