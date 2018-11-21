module Supervisor.Package exposing (addPackage, compareVersions, constraintComparatorToDepComparator, constraintResult, cucumberConstraintString, cucumberElmPackageName, cucumberVersionString, elmVersionString, elmiModuleListDecoder, findCucumberDep, mapUserProjectToCucumberProject, nameResult, parseProject, removePackage, validateDep, validateProject, versionResult)

import Elm.Constraint
import Elm.Package
import Elm.Project
import Elm.Version
import Json.Decode as D
import List
import Set
import String.Format


elmVersionString : String
elmVersionString =
    "0.19.0"


cucumberVersionString : String
cucumberVersionString =
    "1.2.3"


versionResult : String -> Result String Elm.Version.Version
versionResult versionString =
    versionString
        |> Elm.Version.fromString
        |> Result.fromMaybe ("Could not parse {{ }}" |> String.Format.value versionString)


cucumberConstraintString : String
cucumberConstraintString =
    "1.2.3 <= x < 2.0.0"


constraintResult : String -> Result String Elm.Constraint.Constraint
constraintResult constraintString =
    constraintString
        |> Elm.Constraint.fromString
        |> Result.fromMaybe ("Could not parse {{ }}" |> String.Format.value constraintString)


cucumberElmPackageName : String
cucumberElmPackageName =
    "genthaler/cucumber-elm"


nameResult : String -> Result String Elm.Package.Name
nameResult name =
    Elm.Package.fromString name
        |> Result.fromMaybe ("Some weird problem converting {{ }} into an Elm.Package.Name" |> String.Format.value name)


constraintComparatorToDepComparator : (Elm.Version.Version -> constraint -> Bool) -> (( Elm.Package.Name, Elm.Version.Version ) -> ( Elm.Package.Name, constraint ) -> Bool)
constraintComparatorToDepComparator compare =
    let
        compare_ ( name1, version ) ( name2, constraint ) =
            name1 == name2 && compare version constraint
    in
    compare_


addPackage : Elm.Project.Deps constraint -> ( Elm.Package.Name, constraint ) -> Elm.Project.Deps constraint
addPackage deps dep =
    dep :: removePackage deps dep


removePackage : Elm.Project.Deps constraint -> ( Elm.Package.Name, constraint ) -> Elm.Project.Deps constraint
removePackage deps dep =
    List.filter ((/=) dep) deps


findCucumberDep : String -> Elm.Project.Deps a -> Result String a
findCucumberDep errorTemplate list =
    list
        |> List.filter (\( name, _ ) -> Elm.Package.toString name == cucumberElmPackageName)
        |> List.head
        |> Maybe.map Tuple.second
        |> Result.fromMaybe
            (errorTemplate |> String.Format.value cucumberElmPackageName)


parseProject : String -> Result String Elm.Project.Project
parseProject =
    D.decodeString Elm.Project.decoder
        >> Result.mapError D.errorToString
        >> Result.andThen validateProject


compareVersions a b =
    Elm.Version.compare a b == EQ


validateDep : String -> (a -> b -> Bool) -> (a -> String) -> (b -> String) -> a -> b -> Result String ()
validateDep errorTemplate compare aToString bToString depVersion version =
    if compare depVersion version then
        Ok ()

    else
        Err
            (errorTemplate
                |> (String.Format.value << aToString) depVersion
                |> (String.Format.value << bToString) version
            )


validateProject : Elm.Project.Project -> Result String Elm.Project.Project
validateProject project =
    let
        validate findCucumberDepErrorTemplate dependencies versionCompare aToString bToString elmVersion =
            let
                mapCompare errorTemplate =
                    Result.map2 (validateDep errorTemplate versionCompare aToString bToString)
            in
            Result.map2
                always
                (mapCompare "Cucumber dependency {{ }} does not match the Cucumber version {{ }} used by elm-cuke to run the feature(s)."
                    (versionResult cucumberVersionString)
                    (findCucumberDep findCucumberDepErrorTemplate dependencies)
                )
                (mapCompare "Elm version used to compile the Runner {{ }} does not match the Elm version {{ }} used by elm-cuke to run the feature(s)."
                    (versionResult elmVersionString)
                    (Ok elmVersion)
                )
                |> Result.map (always project)
    in
    case project of
        Elm.Project.Application applicationInfo ->
            validate
                "{{ }} is not listed in direct or indirect dependencies"
                (applicationInfo.depsDirect ++ applicationInfo.depsIndirect)
                compareVersions
                Elm.Version.toString
                Elm.Version.toString
                applicationInfo.elm

        Elm.Project.Package packageInfo ->
            validate
                "{{ }} is not listed in dependencies"
                packageInfo.deps
                Elm.Constraint.check
                Elm.Version.toString
                Elm.Constraint.toString
                packageInfo.elm


{-| Take a regular elm.json, and turn it into an elm.json that can be used to compile and run a Cucumber test suite.

This entails adding cucumber to the dependencies, and swizzling the source directories so they point to the right locations.

-}
mapUserProjectToCucumberProject : Elm.Project.Project -> Result String Elm.Project.Project
mapUserProjectToCucumberProject project =
    case project of
        Elm.Project.Application { elm, dirs, depsDirect, depsIndirect, testDepsDirect, testDepsIndirect } ->
            Result.map2 Tuple.pair (nameResult cucumberElmPackageName) (versionResult cucumberVersionString)
                |> Result.map
                    (\dep_ -> Elm.Project.Application <| Elm.Project.ApplicationInfo elm dirs (addPackage depsDirect dep_) (removePackage depsIndirect dep_) testDepsDirect testDepsIndirect)

        Elm.Project.Package { name, summary, license, version, exposed, deps, testDeps, elm } ->
            Result.map2 Tuple.pair (nameResult cucumberElmPackageName) (constraintResult cucumberConstraintString)
                |> Result.map
                    (\dep_ -> Elm.Project.Package <| Elm.Project.PackageInfo name summary license version exposed (addPackage deps dep_) testDeps elm)


{-| Decodes the output of elmi-to-json into a list of tuples of module name and list of names of methods for the module that implement Stepdefs
-}
elmiModuleListDecoder : D.Decoder (List ( String, List String ))
elmiModuleListDecoder =
    D.list <|
        D.map2 Tuple.pair
            (D.field "moduleName" D.string)
            (D.field "interface" <|
                D.field "types" <|
                    D.map
                        (List.filterMap
                            (\( typeName, argTypeList ) ->
                                argTypeList
                                    |> List.reverse
                                    |> List.head
                                    |> Maybe.andThen
                                        (\( moduleName, name ) ->
                                            case ( moduleName, name ) of
                                                ( "Cucumber.StepDefs", "StepDefFunctionResult" ) ->
                                                    Just typeName

                                                _ ->
                                                    Nothing
                                        )
                            )
                        )
                    <|
                        D.keyValuePairs <|
                            D.field "annotation" <|
                                D.field "lambda" <|
                                    D.list <|
                                        D.map2 Tuple.pair
                                            (D.field "moduleName" <| D.field "module" D.string)
                                            (D.field "name" D.string)
            )
