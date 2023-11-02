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

*** Variables ***
${TEST_FILE}                ${file_4mb}
${EXTRACTION_TIMEOUT}       60s

*** Test Cases ***
Find and open Enable Debug Output
    [Documentation]    Click Options, then toggle on/off Enable Debug output button and verify if Reload Badge appears/disappears
    [Tags]    options

    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}

    Click Element    ${EnableDebugSwitch}
    Wait Until Element Is Visible    ${ReloadBadge}

    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${TEST_FILE}[archive_name].zip

    Click Add Files Button
    Ubuntu Upload Test File    ${TEST_FILE}[path]
    Click Load Button
    Check If Log Console Contains    Opening "${TEST_FILE}[name]"

    Wait Until Element Is Not Visible    ${ReloadBadge}

    Click Element    ${EnableDebugSwitch}
    Wait Until Element Is Visible    ${ReloadBadge}

    Click Add Files Button
    Ubuntu Upload Test File    ${TEST_FILE}[path]
    Click Load Button
    Check If Log Console Contains    Opening "${TEST_FILE}[name]"


