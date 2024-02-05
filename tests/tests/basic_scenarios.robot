*** Settings ***
Documentation       Basic scenarios

Library             OperatingSystem
Library             SeleniumLibrary
Library             String
Library             random
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Library             src/page_objects/libraries/browser_lib.py
Variables           src/page_objects/locators/locators.py
Variables           variables.py

Test Teardown       Reload Page

*** Keywords ***
Add file
    [Arguments]    ${test_file}
    Wait Until Keyword Succeeds    5    1    Click Add Files Button
    Upload Test File    ${test_file}[path]

Validate loaded file
    [Arguments]    ${test_file}
    Check If Log Console Contains    Opening "${test_file}[name]"
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}
    Validate Output Description    ${test_file}[archive_name]
    Validate Output Archive File Size    ${test_file}[archive_size_bytes]
    Validate Output Archive Files Number    ${test_file}[files_in_archive]
    Element Text Should Be    ${LoadedFileName}     ${test_file}[archive_name]
    Element Should Be Visible    ${DirectoryTree}
    Element Text Should Be    ${DirectoryTree}    ${test_file}[archive_name]


*** Test Cases ***
Add single file
    Page Should Contain Element    ${EmptyListInfo}
    Page Should Not Contain Element    ${RadioButton}
    ${test_file}=    Select random file
    Add file    ${test_file}
    Wait Until Element Is Visible    ${AddedFile.format("${test_file}[name]")}
    Page Should Contain Element    ${RadioButton}

Add multiple files
    Page Should Contain Element    ${EmptyListInfo}
    Page Should Not Contain Element    ${RadioButton}
    ${number_of_files}=    Evaluate   random.randint(1, 5)
    FOR    ${counter}    IN RANGE   ${number_of_files}
            ${test_file}=    Select random file
            Add file    ${test_file}
            Wait Until Element Is Visible    ${AddedFile.format("${test_file}[name]")}
            ${radio_buttons_amount}    Get Element Count    ${RadioButton}
            Should Be Equal As Numbers    ${radio_buttons_amount}    ${counter+1}
    END

Remove single file   
    ${test_file}=   Select random file
    Add file    ${test_file}  
    Wait Until Element Is Visible    ${AddedFile.format("${test_file}[name]")}
    ${radio_buttons_amount}    Get Element Count    ${RadioButton}
    Should Be Equal As Numbers    1    ${radio_buttons_amount}
    Select Radio Button    exeRadio    0
    Click Remove Button
    ${radio_buttons_amount}    Get Element Count    ${RadioButton}
    Should Be Equal As Numbers    0    ${radio_buttons_amount}
    Wait Until Element Is Not Visible    ${AddedFile.format("${test_file}[name]")}
    Page Should Contain Element    ${EmptyListInfo}

Add multiple files and remove one   
    @{test_names}    Create List
    ${number_of_files}=    Evaluate   random.randint(1, 5)
    FOR    ${counter}    IN RANGE   ${number_of_files}
            ${test_file}=    Select random file
            Add file    ${test_file}
            Log To Console    Added file name: ${test_file}[name]
            Append To List    ${test_names}    ${test_file}[name]
    END
    ${random_file}=    Evaluate   random.randint(0, ${number_of_files-1})
    ${file_to_remove}    Set Variable    ${AddedFile.format("${test_names}[${random_file}]")}

    ${count_added}    Get Element Count    ${file_to_remove}  
    Select Radio Button    exeRadio  ${random_file} 
    Click Remove Button
    ${radio_buttons_amount}    Get Element Count    ${RadioButton}
    Should Be Equal As Numbers    ${number_of_files-1}    ${radio_buttons_amount}
    ${count_after_removal}    Get Element Count     ${file_to_remove}
    Should Be Equal As Numbers    ${count_after_removal}    ${count_added-1}

Load and reload file
    FOR    ${file}    IN    @{TestFiles}
        ${test_file}    Set Variable    ${TestFiles}[${file}]
        Add file    ${test_file}
        Wait Until Element Is Visible    ${AddedFile.format("${test_file}[name]")}
        Click Load Button
        Validate loaded file     ${test_file}
    END