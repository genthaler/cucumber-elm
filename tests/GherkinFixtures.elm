module GherkinFixtures exposing (..)

import Gherkin exposing (..)


{-| defer execution
-}
defer : a -> (() -> a)
defer x =
    \() -> x


noTags =
    []


tagBlah =
    [ "blah" ]


tagsFooBar =
    [ "foo", "bar" ]


givenTheQuickBrownFox =
    Step Given "the quick brown fox" NoArg


givenJumpsOverTheLazyDog =
    Step Given "jumps over the lazy dog" NoArg


givenIAmTryingToHaveFun =
    Step Given "I am trying to have fun" <| DataTable table1


givenTheWorldIsRound =
    Step Given "the world is round" NoArg


nowIsTheTime =
    "Now is the time"


tableRowContent =
    "| Now | is | the | time | "


table1 =
    Table [ "Now", "is", "the", "time" ]
        [ [ "For", "all", "good", "men" ]
        ]


tableContent1 =
    """ | Now | is | the | time |
          | For | all | good | men | """


table2 =
    Table [ "Now" ]
        [ [ "For" ]
        ]


stepContent =
    """Given I am trying to have fun
  | Now | is | the | time |
  | For | all | good | men | """


stepContent2 =
    "But I am trying not to be a fool\n"


butIAmTryingNotToBeAFool =
    Step But "I am trying not to be a fool" NoArg


background1 =
    Background "pack my box" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ]


background2 =
    Background "Some basic info" [ givenTheWorldIsRound ]


backgroundContent2 =
    """Background: Some basic info
      Given the world is round
  """


simpleScenario =
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
    Scenario tagsFooBar "Have fun" [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]


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
    ScenarioOutline tagsFooBar
        "Have fun"
        [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        [ examplesWithTag ]


examples =
    Examples [] table2


examplesWithTag =
    Examples tagBlah table2


examplesContentWithTag =
    """@blah
    Examples:
      | Now |
      | For | """


simpleFeature : Feature
simpleFeature =
    Feature []
        "Feature Runner"
        (AsA "regular person")
        (InOrderTo "verify a feature")
        (IWantTo "supply some glue code and run it against the feature")
        background1
        [ simpleScenario ]


simpleFeatureContent =
    """Feature: Feature Runner
As a regular person
In order to verify a simpleFeature
I want to supply some glue code and run it against the simpleFeature
Background: pack my box
Given the quick brown fox
Scenario: with five dozen liquor jugs
Given the quick brown fox
When jumps over the lazy dog
"""


feature =
    Feature []
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        background2
        [ scenario ]


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
            [ (Examples tagBlah table2) ]
        ]


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
