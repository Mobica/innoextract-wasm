*** Settings ***
Library  SeleniumLibrary
Library  ../libraries/custom.py
Variables  ../locators/locators.py

*** Keywords ***
Click Add Files Button
    Click Element  ${AddFilesButton}
    Log  Click Add Files Button  console=yes

Click Extract And Save Button
    Click Element  ${ExtractAndSaveButton}
    Wait Until Page Contains    100%
    Log  Click Extract And Save Button  console=yes

Click Remove Button
    Click Element  ${RemoveButton}
    Log  Click Remove Button  console=yes

Click Start Button
    Click Element  ${StartButton}
    Log  Click Start Button  console=yes

<<<<<<< HEAD
Log Console Is Visible
    Wait Until Element Is Visible   css=${CollapseLogsButton}
    ${variable}    Run Keyword And Return Status    Element Should Be Visible   xpath=${LogsTitle}
    RETURN    ${variable}

 Click Show/Hide Logs Button
    Click Element    css=${CollapseLogsButton}

Unhide Log Window
    Log    Unhide window with logs
    ${status} =   Log Console Is Visible
    Run Keyword If    ${status} == False  Click Show/Hide Logs Button
    Wait Until Element Is Visible   xpath=${LogsTitle}

Check If Log Console Contains
    [Arguments]    ${message}    ${timeout}=5
    Unhide Log Window
    Wait Until Element Contains    ${LogsConsole}    ${message}    ${timeout}
    
Check If Log Console Does Not Contain Errors
    Log    Check if there are no errors or warnings in the Log Console   console=yes
    @{possible_errors}     Create List    warning    error    conflict    wrong
    FOR    ${element}    IN    @{possible_errors}
        Element Should Not Contain    ${LogsConsole}    ${element}    ignore_case=True
    END

Validate File Details In Log Console
    [Arguments]    ${file}
    Log    Validate file details in Log Console    console=yes
    Check If Log Console Contains    Total size: ${file}[archive_size_bytes] bytes    10
    Check If Log Console Contains    Done. Creating ZIP file
=======
Validate Output Description
    [Arguments]    ${expected_output}
    ${output} =    Get Text    ${Description}  
    Wait Until Element Contains    ${Description}    ${expected_output}
    ...    error=Expected output: ${expected_output}, read from Web: ${output}

Validate Archive File
    [Arguments]    ${size}    ${files_num}
    ${output_filenum} =    Get Text    ${FileNum} 
    Wait Until Element Contains    ${FileNum}    ${files_num}
    ...    error=Number of files: ${output_filenum} expected: ${files_num}

    ${output_size} =    Get Text    ${FileSize}
    ${size} =   Convert To Mega    ${size} 
    Wait Until Element Contains    ${FileSize}    ${size}    error=File size: ${output_size}, expected: ${size}
>>>>>>> 836431f (Added Validation for archive file details)
