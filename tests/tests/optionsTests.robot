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
Enable Debug Output functionality test    
    [Documentation]    Enable debug output functionality adds debug logs if selected
    [Tags]    options

    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${TEST_FILE}[archive_name].zip

    Click Add Files Button
    Ubuntu Upload Test File    ${TEST_FILE}[path]
    Click Load Button
    Check If Log Console Contains    Opening "${TEST_FILE}[name]"
    Validate Output Description    ${TEST_FILE}[archive_name]
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}
    Click Extract And Save Button    ${EXTRACTION_TIMEOUT}
    Validate File Details In Log Console    ${TEST_FILE}
    Check If Log Console Does Not Contain    loaded
    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}
    Click Element    ${EnableDebugSwitch}
    Click Load Button
    Check If Log Console Contains    Opening "${TEST_FILE}[name]"
    Validate Output Description    ${TEST_FILE}[archive_name]
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}
    Click Extract And Save Button    ${EXTRACTION_TIMEOUT}
    Validate File Details In Log Console    ${TEST_FILE}
    Check If Log Console Contains    loaded


