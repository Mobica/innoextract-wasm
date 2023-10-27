*** Settings ***
Documentation       Options Tests

Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Resource            src/page_objects/keywords/ubuntu.robot
Resource            src/test_files/test_files.resource
Library             src/page_objects/libraries/browser_lib.py

Suite Setup         Prepare Test Environment
Test Setup          Prepare For Test
Test Teardown       Clean After Test


*** Test Cases ***
Find and open Enable Debug Output
    [Documentation]    Click Options, then toggle on/off Enable Debug output button and verify if Reload Badge appears/disappears
    [Tags]    options

    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}

    Click Element    ${EnableDebugSwitch}
    Wait Until Element Is Visible    ${ReloadBadge}

    Click Element    ${EnableDebugSwitch}
    Wait Until Element Is Not Visible    ${ReloadBadge}

Find and open Exclude temporary files
    [Documentation]    Click Options, then toggle on/off Exclude temporary files switch button and verify if Reload Badge appears/disappears
    [Tags]    options

    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}

    Click Element    ${ExcludeTemporaryFilesSwitch}
    Wait Until Element Is Visible    ${ReloadBadge}

    Click Element    ${ExcludeTemporaryFilesSwitch}
    Wait Until Element Is Not Visible    ${ReloadBadge}

Find and open Output logs to a file
    [Documentation]    Click Options, then toggle on/off Output logs to a file button and verify if Reload Badge appears/disappears
    [Tags]    options

    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}

    Click Element    ${OutputLogsSwitch}
    Wait Until Element Is Visible    ${LogsButton}
    Wait Until Element Is Not Visible    ${ReloadBadge}

Find and open Extraction language filter option
    [Documentation]    Click    Options, then Extraction language filter option, select every option and verify if Reload Badge appears/disappears
    [Tags]    option

    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}

    Click Element    ${ExtractionLangFilterOption}

    Click Element    ${EverythingOption}
    Wait Until Element Is Visible    ${ReloadBadge}

    Click Element    ${OnlyChosenLanguageOption}
    Wait Until Element Is Visible    ${ReloadBadge}

    Click Element    ${OnlyLanguageAgnosticOption}
    Wait Until Element Is Visible    ${ReloadBadge}

    Click Element    ${ChosenLanguageAndLangAgnosticOption}
    Wait Until Element Is Not Visible    ${ReloadBadge}

Find and open Collision resolution option
    [Documentation]    Click Option, then Collision resolution option, select every option and verify if Reload Badge appears/disappears
    [Tags]    options

    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}

    Click Element    ${CollisionResolutionOption}

    Click Element    ${OverwriteOption}
    Wait Until Element Is Not Visible    ${ReloadBadge}

    Click Element    ${RenameOption}
    Wait Until Element Is Visible    ${ReloadBadge}

    Click Element    ${RenameAllOption}
    Wait Until Element Is Visible    ${ReloadBadge}

    Click Element    ${ErrorOption}
    Wait Until Element Is Visible    ${ReloadBadge}
