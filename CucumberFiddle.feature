Feature: Cucumber Fiddle application
    As a BDD practitioner
    In order to work in a BDD Elm environment
    I want to be able to run Gherkin features against an Elm codebase and see how well the codebase matches the features

    Background:
        Given I have loaded the CucumberFiddle application

    Scenario: Show list of available features on the server
        Then I can see the list of available features

    Scenario: Selecting a feature from the server
        When I select a feature from the list of available features
        Then I can see the feature

    Scenario: Selecting a feature from the client
        When I select a feature file from local
        Then I can see the feature
