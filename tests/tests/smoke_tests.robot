*** Settings ***
Documentation       Smoke Tests

Library             OperatingSystem
Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Library             src/page_objects/libraries/browser_lib.py
Variables           variables.py

Test Teardown       Clean After Test


*** Variables ***
${extraction_timeout}       60s


*** Keywords ***
Extract test file
    [Arguments]    ${test_file}
    # TODO: Move some steps to TEST SETUP or SUITE SETUP
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${test_file}[archive_name].zip
    Click Add Files Button
    Upload Test File    ${test_file}[path]
    Click Load Button
    Check If Log Console Contains    Opening "${test_file}[name]"
    Validate Output Description    ${test_file}[archive_name]
    Validate Output Archive File Size    ${test_file}[archive_size_bytes]
    Validate Output Archive Files Number    ${test_file}[files_in_archive]
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}

    Click Extract And Save Button    ${test_file}[extraction_time]
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
        ${TestFiles}[${file}]
    END

Corrupted File Test
    [Documentation]    Test to check if file with corrupted header/non inno setup file shows error popup
    [Tags]    smoke    negative
    ${test_file}    Set Variable    ${Corrupted_file}
    Click Add Files Button
    Upload Test File    ${test_file}[path]
    Click Load Button

    Element Should Be Visible    ${ErrorPopup}
    Element Text Should Be    ${ErrorPopupMsg}    Not a supported Inno Setup installer!
    Click Button    ${ErrorPopupCloseBtn}

    Check If Log Console Contains    Opening "${test_file}[name]"
    Check If Log Console Contains    Not a supported Inno Setup installer!
    [Teardown]    NONE