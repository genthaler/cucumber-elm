module GherkinFixtures exposing (background1, background2, backgroundContent2, butIAmTryingNotToBeAFool, defer, examples, examplesContentWithTag, examplesWithTag, feature, featureContent, featureWith2ScenariosWithTagsContent, featureWithScenarioOutlineWithExamplesWithTags, featureWithScenarioOutlineWithExamplesWithTagsContent, featureWithScenarioWithTags, featureWithTags, featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags, featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent, givenIAmTryingToHaveFun, givenJumpsOverTheLazyDog, givenTheQuickBrownFox, givenTheWorldIsRound, noTags, nowIsTheTime, scenario, scenarioContent, scenarioOutline, scenarioOutlineContent, scenarioOutlineWithTags, scenarioOutlineWithTagsContent, scenarioWithTags, scenarioWithTagsContent, simpleFeature, simpleFeatureContent, simpleScenario, stepContent, stepContent2, table1, table2, tableContent1, tableRowContent, tagBlah, tagsFooBar)

import Gherkin exposing (..)


{-| defer execution
-}
defer : a -> (() -> a)
defer x =
    \() -> x


noTags : List a
noTags =
    []


tagBlah : List Tag
tagBlah =
    [ Tag "blah" ]


tagsFooBar : List Tag
tagsFooBar =
    [ Tag "foo", Tag "bar" ]


givenTheQuickBrownFox : Step
givenTheQuickBrownFox =
    Step Given "the quick brown fox" NoArg


givenJumpsOverTheLazyDog : Step
givenJumpsOverTheLazyDog =
    Step Given "jumps over the lazy dog" NoArg


givenIAmTryingToHaveFun : Step
givenIAmTryingToHaveFun =
    Step Given "I am trying to have fun" <| DataTable table1


givenTheWorldIsRound : Step
givenTheWorldIsRound =
    Step Given "the world is round" NoArg


nowIsTheTime : String
nowIsTheTime =
    "Now is the time"


tableRowContent : String
tableRowContent =
    "| Now | is | the | time |\n"


table1 : Table
table1 =
    Table [ "Now", "is", "the", "time" ]
        [ [ "For", "all", "good", "men" ]
        ]


tableContent1 : String
tableContent1 =
    """| Now | is | the | time |
          | For | all | good | men | 
    """


table2 : Table
table2 =
    Table [ "Now" ]
        [ [ "For" ]
        ]


stepContent : String
stepContent =
    """Given I am trying to have fun
  | Now | is | the | time |
  | For | all | good | men | 
  """


stepContent2 : String
stepContent2 =
    "But I am trying not to be a fool\n"


butIAmTryingNotToBeAFool : Step
butIAmTryingNotToBeAFool =
    Step But "I am trying not to be a fool" NoArg


background1 : Background
background1 =
    Background "pack my box" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ]


background2 : Background
background2 =
    Background "Some basic info" [ givenTheWorldIsRound ]


backgroundContent2 : String
backgroundContent2 =
    """Background: Some basic info
      Given the world is round
  """


simpleScenario : Scenario
simpleScenario =
    Scenario [] "with five dozen liquor jugs" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ]


scenarioContent : String
scenarioContent =
    """Scenario: Have fun
  Given I am trying to have fun
    | Now | is | the | time |
    | For | all | good | men |
  But I am trying not to be a fool
"""


scenario : Scenario
scenario =
    Scenario [] "Have fun" [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]


scenarioWithTagsContent : String
scenarioWithTagsContent =
    """@foo
  @bar
  Scenario: Have fun
    Given I am trying to have fun
      | Now | is | the | time |
      | For | all | good | men |
    But I am trying not to be a fool
  """


scenarioWithTags : Scenario
scenarioWithTags =
    Scenario tagsFooBar "Have fun" [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]


scenarioOutlineContent : String
scenarioOutlineContent =
    """Scenario Outline: Have fun
      Given I am trying to have fun
        | Now | is | the | time |
        | For | all | good | men |
      But I am trying not to be a fool
      Examples:
        | Now |
        | For |
    """


scenarioOutline : Scenario
scenarioOutline =
    ScenarioOutline []
        "Have fun"
        [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        [ examples ]


scenarioOutlineWithTagsContent : String
scenarioOutlineWithTagsContent =
    """@foo
    @bar
    Scenario Outline: Have fun
      Given I am trying to have fun
        | Now | is | the | time |
        | For | all | good | men |
      But I am trying not to be a fool
      @blah
      Examples:
        | Now |
        | For |
    """


scenarioOutlineWithTags : Scenario
scenarioOutlineWithTags =
    ScenarioOutline tagsFooBar
        "Have fun"
        [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        [ examplesWithTag ]


examples : Examples
examples =
    Examples [] table2


examplesWithTag : Examples
examplesWithTag =
    Examples tagBlah table2


examplesContentWithTag : String
examplesContentWithTag =
    """@blah
    Examples:
      | Now |
      | For | 
    """


simpleFeature : Feature
simpleFeature =
    Feature []
        "Feature Runner"
        (AsA "regular person")
        (InOrderTo "verify a feature")
        (IWantTo "supply some glue code and run it against the feature")
        background1
        [ simpleScenario ]


simpleFeatureContent : String
simpleFeatureContent =
    """Feature: Feature Runner
As a regular person
In order to verify a simpleFeature
I want to supply some glue code and run it against the simpleFeature
Background: pack my box
Given the quick brown fox
Scenario: with six dozen liquor jugs
Given the quick brown fox
When jumps over the lazy dog
"""


feature : Feature
feature =
    Feature []
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        background2
        [ scenario ]


featureContent : String
featureContent =
    """Feature: Living life
  As a person
  In order to get through life
  I want to be able to do stuff

  Background: Some basic info
    Given the world is round

  Scenario: Have fun
    Given I am trying to have fun
      | Now | is | the | time |
      | For | all | good | men |
    But I am trying not to be a fool
  """


featureWith2ScenariosWithTagsContent : String
featureWith2ScenariosWithTagsContent =
    """Feature: Living life
  As a person
  In order to get through life
  I want to be able to do stuff

  @foo
  Scenario: Try failing
    Given fail

  @bar
  Scenario: Try passing
    Given pass
  """


featureWithTags : Feature
featureWithTags =
    Feature tagsFooBar
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ Scenario []
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        ]


featureWithScenarioWithTags : Feature
featureWithScenarioWithTags =
    Feature []
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ Scenario tagsFooBar
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        ]


featureWithScenarioOutlineWithExamplesWithTags : Feature
featureWithScenarioOutlineWithExamplesWithTags =
    Feature noTags
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ ScenarioOutline []
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
            [ Examples tagBlah table2 ]
        ]


featureWithScenarioOutlineWithExamplesWithTagsContent : String
featureWithScenarioOutlineWithExamplesWithTagsContent =
    """Feature: Living life
  As a person
  In order to get through life
  I want to be able to do stuff
  Background: Some basic info
  Given the world is round
  Scenario Outline: Have <Now> fun
  Given I am trying to have fun
  | Now | is | the | time |
  | For | all | good | men |
  But I am trying not to be a fool
  And <fail>
  @blah
  Examples:
    | fail |
    | pass |
  """


featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags : Feature
featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags =
    Feature tagsFooBar
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ Scenario tagsFooBar
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        , ScenarioOutline tagsFooBar
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
            [ Examples tagBlah table2 ]
        ]


featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent : String
featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent =
    """@foo
  @bar
  Feature: Living life
  As a person
  In order to get through life
  I want to be able to do stuff

  Background: Some basic info
    Given the world is round

  @foo
  @bar
  Scenario: Have fun
    Given I am trying to have fun
      | Now | is | the | time |
      | For | all | good | men |
    But I am trying not to be a fool

  @foo
  @bar
  Scenario Outline: Have fun
    Given I am trying to have fun
      | Now | is | the | time |
      | For | all | good | men |
    But I am trying not to be a fool
    @blah
    Examples:
      | Now |
      | For |
  """
