*** Settings ***
Documentation       Smoke Tests

Library             OperatingSystem
Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Resource            src/page_objects/keywords/ubuntu.robot
Resource            src/test_files/test_files.resource
Library             src/page_objects/libraries/browser_lib.py
Variables           src/test_files/test_files.yaml
Variables           variables.py

Test Teardown       Clean After Test


*** Variables ***
${extraction_timeout}       60s


*** Keywords ***
Extract test file
    [Arguments]    ${test_file}
    # TODO: Move some steps to TEST SETUP or SUITE SETUP
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${test_file}[archive_name].zip
    ${path}    Set Variable    ${test_files_directory_path}${test_file}[name]
    Click Add Files Button
    Upload Test File    ${path}
    Click Load Button
    Check If Log Console Contains    Opening "${test_file}[name]"
    Validate Output Description    ${test_file}[archive_name]
    Validate Output Archive File Size    ${test_file}[archive_size_bytes]
    Validate Output Archive Files Number    ${test_file}[files_in_archive]
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}

    Click Extract And Save Button    ${extraction_timeout}
    Wait Until Created    ${downloaded_file_path}

    Validate and Unzip Test File    ${downloaded_file_path}
    Validate File Details In Log Console    ${test_file}
    Check If Log Console Does Not Contain Errors
    Check If JS Console Does Not Contain Errors


*** Test Cases ***
Extract multiple files
    [Documentation]    Extract smoke file successfully
    [Tags]    smoke
    [Template]    Extract test file
    FOR    ${file}    IN    @{TestFiles}
        ${file}
    END