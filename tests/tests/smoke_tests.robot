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

#Suite Setup         Prepare Test Environment
#Test Setup          Prepare For Test
#Test Teardown       Clean After Test


*** Variables ***
${extraction_timeout}       60s


*** Test Cases ***
Extract test file
    [Documentation]    Extract smoke file successfully
    [Tags]    smoke
    # TODO: Move some steps to TEST SETUP or SUITE SETUP
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${file_4mb}[archive_name].zip

    Click Add Files Button
    Ubuntu Upload Test File    ${file_4mb}[path]
    Click Load Button
    Check If Log Console Contains    Opening "${file_4mb}[name]"
    Validate Output Description    ${file_4mb}[archive_name]
    Validate Output Archive File Size    ${file_4mb}[archive_size_bytes]
    Validate Output Archive Files Number    ${file_4mb}[files_in_archive]
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}

    Click Extract And Save Button    ${extraction_timeout}
    Wait Until Created    ${downloaded_file_path}

    Validate and Unzip Test File    ${downloaded_file_path}
    Validate File Details In Log Console    ${file_4mb}
    Check If Log Console Does Not Contain Errors
    Check If JS Console Does Not Contain Errors
