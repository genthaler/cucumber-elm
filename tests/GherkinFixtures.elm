module GherkinFixtures exposing (..)

import Gherkin exposing (..)


{-| defer execution
-}
defer : a -> (() -> a)
defer x =
    \() -> x


tag =
    [ "blah" ]


tags =
    [ "foo", "bar" ]


givenTheQuickBrownFox =
    Given "the quick brown fox" NoArg


givenJumpsOverTheLazyDog =
    Given "jumps over the lazy dog" NoArg


givenIAmTryingToHaveFun =
    Given "I am trying to have fun" <| DataTable table1


givenTheWorldIsRound =
    Given "the world is round" NoArg


nowIsTheTime =
    "Now is the time"


tableRowContent =
    "| Now | is | the | time | "


table1 =
    [ [ "Now", "is", "the", "time" ]
    , [ "For", "all", "good", "men" ]
    ]


tableContent1 =
    """ | Now | is | the | time |
          | For | all | good | men | """


table2 =
    [ [ "Now" ]
    , [ "For" ]
    ]


stepContent =
    """Given I am trying to have fun
  | Now | is | the | time |
  | For | all | good | men | """


stepContent2 =
    "But I am trying not to be a fool\n"


butIAmTryingNotToBeAFool =
    But "I am trying not to be a fool" NoArg


background1 =
    Background "pack my box" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ]


background2 =
    Background "Some basic info" [ givenTheWorldIsRound ]


backgroundContent2 =
    """Background: Some basic info
      Given the world is round
  """


scenario1 =
    Scenario [] "with five dozen liquor jugs" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ]


scenarioContent =
    """Scenario: Have fun
  Given I am trying to have fun
    | Now | is | the | time |
    | For | all | good | men |
  But I am trying not to be a fool
"""


scenario =
    Scenario [] "Have fun" [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]


scenarioWithTagsContent =
    """@foo
  @bar
  Scenario: Have fun
    Given I am trying to have fun
      | Now | is | the | time |
      | For | all | good | men |
    But I am trying not to be a fool
  """


scenarioWithTags =
    Scenario tags "Have fun" [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]


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


scenarioOutline =
    ScenarioOutline []
        "Have fun"
        [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        [ examples ]


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


scenarioOutlineWithTags =
    ScenarioOutline tags
        "Have fun"
        [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        [ examplesWithTag ]


examples =
    Examples [] table2


examplesWithTag =
    Examples tag table2


examplesContentWithTag =
    """@blah
    Examples:
      | Now |
      | For | """


feature : Feature
feature =
    Feature []
        "Feature Runner"
        (AsA "regular person")
        (InOrderTo "verify a feature")
        (IWantTo "supply some glue code and run it against the feature")
        background1
        [ scenario1 ]


featureContent =
    """Feature: Feature Runner
As a regular person
In order to verify a feature
I want to supply some glue code and run it against the feature
Background: pack my box
Given the quick brown fox
Scenario: with five dozen liquor jugs
Given the quick brown fox
When jumps over the lazy dog
"""


feature2 =
    Feature []
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        background2
        [ Scenario []
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        ]


featureContent2 =
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


feature3 =
    Feature tags
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ Scenario tags
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        , ScenarioOutline tags
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
            [ Examples tag table2 ]
        ]


featureContent3 =
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
