*** Settings ***
Documentation  Multiple Files Tests

Library             OperatingSystem
Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Resource            src/page_objects/keywords/ubuntu.robot
Library             src/page_objects/libraries/browser_lib.py
Library             Collections
Variables           src/page_objects/locators/locators.py
Variables           variables.py

Test Teardown    Clean After Test

*** Variables ***
${extraction_timeout}       60s


*** Test Cases ***
# TODO: Test is failing because of known issue
Extract two files one by one test
    [Documentation]    Extract two files one by one
    [Tags]    multiple    performance

    # Adding and Extracting First File
    ${test_file}=    Select random file
    Extract File    ${test_file}    ${test_file}[path]
    Check If Zip File Is Not Empty    ${DOWNLOAD_PATH}    ${test_file}
    # Adding and Extracting Second File
    Rename Downloaded Zip File Name    ${DOWNLOAD_PATH}    ${test_file}
    Clean Input List
    ${test_file}=    Select random file
    Extract File    ${test_file}    ${test_file}[path]
    Check If Zip File Is Not Empty    ${DOWNLOAD_PATH}    ${test_file}

Extract multiple files test
    [Documentation]    Extract file consisting of multiple files
    [Tags]    multiple    performance
    Log To Console    Extracting file consisting of multiple files
    ${test_file}    Set Variable    ${Multi_part_4MB}
    Extract Multiple Files    ${test_file}    ${DOWNLOAD_PATH}
    Check If Zip File Is Not Empty    ${DOWNLOAD_PATH}    ${test_file}
    Clean Input List

Extract all files test
    [Documentation]    Extract all test files
    [Tags]    multiple    performance    all
    FOR    ${file}    IN    @{TestFiles}
        ${test_file}    Set Variable   ${TestFiles}[${file}]
        Log To Console    Extracting ${test_file}[name]
        ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${test_file}[archive_name].zip
        Extract File    ${test_file}    ${test_file}[path]    ${test_file}[extraction_time]
        Wait Until Created    ${downloaded_file_path}    ${test_file}[extraction_time]
    END
    Close Browser


*** Keywords ***
Extract File
    [Arguments]    ${test_file}    ${test_file_path}    ${extraction_timeout}=30s
    Wait Until Keyword Succeeds    5    1    Click Add Files Button
    Upload Test File    ${test_file_path}
    Click Load Button
    Click Extract And Save Button    ${extraction_timeout}
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}

Extract Multiple Files
    [Arguments]    ${test_file}    ${DOWNLOAD_PATH}
    @{file_list}    Create List
    FOR    ${i}    IN RANGE    1    ${test_file}[parts]
        ${file}    Catenate    ${test_file}[name]-${i}.bin
        Append To List    ${file_list}    ${file}
    END
    Append To List    ${file_list}    ${test_file}[name].exe
    Log To Console    ${file_list}

    FOR    ${file}    IN    @{file_list}
        ${test_file_path}    Set Variable     ${test_file}[path]/${file}
        Wait Until Keyword Succeeds    5    1    Click Add Files Button
        Upload Test File    ${test_file_path}
        Wait Until Element Is Visible    ${AddedFile.format("${test_file}[name]")}
        Wait Until Keyword Succeeds    5    1    Browser Is Selected
    END
    Click Load Button
    Click Extract And Save Button    ${extraction_timeout}

Clean Input List
    ${radio_buttons_amount}    Get Element Count    ${RadioButton}
    FOR    ${button}    IN RANGE    1    ${radio_buttons_amount+1}
        Log To Console    Found ${radio_buttons_amount} radio buttons
        Log    Removing entry from Input List ${button}    console=yes
        Click Button    ${RadioButton}
        Click Remove Button
    END
    Page Should Not Contain Button    ${RadioButton}
