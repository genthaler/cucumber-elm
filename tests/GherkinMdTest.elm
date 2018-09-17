module GherkinMdTest exposing (all)

import Expect exposing (equal, fail, pass)
import GherkinFixtures exposing (..)
import GherkinMd exposing (featureMd)
import GherkinParser
import Test exposing (..)


all : Test
all =
    describe "pretty printing Gherkin as HTML"
        [ test "parses Feature with tagsFooBar correctly" <|
            \_ ->
                let
                    expected =
                        """@foo @bar
# Feature: Living life

> As a person

> In order to get through life
 
> I want to be able to do stuff

## Background: Some basic info

**Given** the world is round





@foo @bar
##Scenario: Have fun

**Given** I am trying to have fun

<table><tr><th>Now</th><th>is</th><th>the</th><th>time</th></tr>
<tr><td>For</td><td>all</td><td>good</td><td>men</td></tr></table>


**But** I am trying not to be a fool







@foo @bar
##Scenario: Have fun

**Given** I am trying to have fun

<table><tr><th>Now</th><th>is</th><th>the</th><th>time</th></tr>
<tr><td>For</td><td>all</td><td>good</td><td>men</td></tr></table>


**But** I am trying not to be a fool





@blah
###Examples:

<table><tr><th>Now</th></tr>
<tr><td>For</td></tr></table>

"""

                    res =
                        GherkinParser.parse
                            GherkinParser.feature
                            featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent
                in
                case res of
                    Ok myFeature ->
                        equal (featureMd myFeature) expected

                    Err error ->
                        fail error
        ]
