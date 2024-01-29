*** Settings ***
Library         OperatingSystem
Library         SeleniumLibrary
Library         String
Library         src/page_objects/libraries/browser_lib.py
Library         Process
Library         Collections
Resource        src/page_objects/keywords/ubuntu.robot
Resource        src/page_objects/keywords/windows.robot
Variables       src/page_objects/locators/locators.py
Variables       variables.py
#Variables       src/test_files/test_files.yaml


*** Keywords ***
Clean After Test
    Empty Directory    ${DOWNLOAD_PATH}

Rename Downloaded Zip File Name
    [Arguments]    ${path}    ${test_file}    ${new_name}=innout    ${postfix}=0    ${new_file_extenion}=.zip
    ${file_name}    Catenate    SEPARATOR=    ${new_name}    ${postfix}    ${new_file_extenion}
    Copy File    ${path}${test_file}[archive_name].zip    ${path}${file_name}
    Wait Until Created    ${path}${file_name}
    Remove File    ${path}${test_file}[archive_name].zip

Check If Zip File Is Not Empty
    [Arguments]    ${path}    ${test_file}
    ${file_path}    Set Variable    ${DOWNLOAD_PATH}${test_file}[archive_name].zip
    Wait Until Created    ${file_path}    timeout=30
    Sleep    5s
    File Should Not Be Empty    ${file_path}
    Log To Console    File created and is not empty - ${file_path}

Check If Downloaded Zip File Is Not Empty
    [Arguments]    ${downloaded_file_path}
    Wait Until Created    ${downloaded_file_path}    timeout=15
    Sleep    5s
    File Should Not Be Empty    ${downloaded_file_path}
    Log To Console    File created and is not empty - ${downloaded_file_path}

Check If JS Console Does Not Contain Errors
    # For firefox logs must be routed to geckodriver.log
    # See profile settings - fp.set_preference("bdevtools.console.stdout.content", True)
    Log to Console    Check if there are no errors in JS console
    File Should Exist    ./output/geckodriver-1.log
    ${file}    Get File    ./output/geckodriver-1.log
    @{file_lines}    Split To Lines    ${file}
    FOR    ${line}    IN    @{file_lines}
        Should Not Contain    ${line}    ERROR
        Should Not Contain    ${line}    Error
        ${error}    String.Get Regexp Matches    ${line}    console\.error: (.*?)$    1
        IF    $error
            ${error_content}    Set Variable    ${error[0]}
            IF    $error_content!='({})'    Fail
        END
    END

Validate ZIP File
    [Arguments]    ${downloaded_file_path}
    Check If Downloaded Zip File Is Not Empty    ${downloaded_file_path}
    ${rc}    ${output}    Run And Return Rc And Output    7za t ${downloaded_file_path}
    Log To Console    output: ${output}
    Should Be Equal As Integers    ${rc}    0
    Should Not Contain    ${output}    FAIL
    Log To Console    ZIP file validated: OK!

Unzip File
    [Arguments]    ${downloaded_file_path}
    ${rc}    ${output}    Run And Return Rc And Output    7za x ${downloaded_file_path} -o${DOWNLOAD_PATH}
    Log To Console    output: ${output}
    Should Be Equal As Integers    ${rc}    0
    Should Not Contain    ${output}    FAIL
    Log To Console    ZIP file extracted successfully!

Validate and Unzip Test File
    [Arguments]    ${downloaded_file_path}
    Log To Console    Validating and unziping file
    Validate ZIP File    ${downloaded_file_path}
    Unzip File    ${downloaded_file_path}

Remove Spaces From File Name
    [Arguments]    ${downloaded_file_path}
    ${downloaded_file_path_new_name}    Replace String    ${downloaded_file_path}    ${space}    ${empty}
    Copy File    ${downloaded_file_path}    ${downloaded_file_path_new_name}
    Wait Until Created    ${downloaded_file_path_new_name}
    RETURN    ${downloaded_file_path_new_name}

Remove Spaces From Directory Name
    [Arguments]    ${downloaded_file_path}
    ${downloaded_file_path_new_name}    Replace String    ${downloaded_file_path}    ${space}    ${empty}
    Copy Directory    ${downloaded_file_path}    ${downloaded_file_path_new_name}
    Wait Until Created    ${downloaded_file_path_new_name}
    Log To Console    Removed spaces from folder name: ${downloaded_file_path_new_name}
    RETURN    ${downloaded_file_path_new_name}

Compare Directory And Files Tree
    [Arguments]    ${path_to_unzipped_folder}    ${path_to_unzipped_folder_pattern}
    ${rc}    ${output}    Run And Return Rc And Output
    ...    diff -qr ${path_to_unzipped_folder} ${path_to_unzipped_folder_pattern}
    Should Be Equal As Integers    ${rc}    0
    Log To Console    Directory tree is the same as pattern: OK.

 Compare Cheksum For Each File
    [Arguments]    ${path_to_unzipped_folder}    ${path_to_unzipped_folder_pattern}
    Log To Console    Checking checksums for    ${path_to_unzipped_folder}
    # rclone is a programm comparing file sizes and hashes for each file in a given path
    ${rc}    ${output}    Run And Return Rc And Output
    ...    rclone check ${path_to_unzipped_folder_pattern} ${path_to_unzipped_folder}
    Should Be Equal As Integers    ${rc}    0
    Log To Console    Checksums and file sizes are the same as pattern: OK.

Upload Test File
    [Arguments]    ${file}
    IF    "${CURRENT_OS}" == "Linux"
        Ubuntu Upload Test File    ${file}
    ELSE IF    "${CURRENT_OS}" == "Windows"
        Windows Upload Test File    ${file}
    ELSE
        Fail    Unknown OS, Aborting test
    END

File Select Is Visible
    IF    "${CURRENT_OS}" == "Linux"
        Ubuntu File Select Is Visible
    ELSE IF    "${CURRENT_OS}" == "Windows"
        Windows File Select Is Visible
    ELSE
        Fail    Unknown OS, Aborting test
    END

Browser Is Selected
    IF    "${CURRENT_OS}" == "Linux"
        Ubuntu Browser Is Selected
    ELSE IF    "${CURRENT_OS}" == "Windows"
        Windows Browser Is Selected
    ELSE
        Fail    Unknown OS, Aborting test
    END

Select random file
    ${test_names}    Get Dictionary Keys    ${TestFiles}
    ${random_file}=    Evaluate   random.choice(${test_names})
    ${file}   Set Variable  ${TestFiles}[${random_file}]
    [return]   ${file}