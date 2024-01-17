*** Settings ***
Documentation       Options Tests

Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Resource            src/page_objects/keywords/ubuntu.robot
Resource            src/test_files/test_files.resource
Library             src/page_objects/libraries/browser_lib.py

*** Variables ***
${OpeningFileText}    //pre[contains(text(),"file_4MB.exe")]
${extraction_timeout}    ${60}
${ErrorText}    //p[@id='errorMsg'][contains(text(),"Aborted: Error due to the file collision")]
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
    Wait Until Element Is Visible    ${LogsButton}
    Click Element    ${OutputLogsSwitch}
    Wait Until Element Is Visible    ${DownloadLogsButton}
    Wait Until Element Is Not Visible    ${ReloadBadge}

Find and open Extraction language filter
    [Documentation]    Click Options, then Extraction language filter option, select every option and verify if Reload Badge appears/disappears
    [Tags]    option

    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}

    Select From List By Index    extractionLanguageFilterOptions    0
    List Selection Should Be    extractionLanguageFilterOptions    lang-plus-agn
    Wait Until Element Is Not Visible    ${ReloadBadge}
    Select From List By Index    extractionLanguageFilterOptions    1
    List Selection Should Be    extractionLanguageFilterOptions    all
    Wait Until Element Is Visible    ${ReloadBadge}
    Select From List By Index    extractionLanguageFilterOptions    2
    List Selection Should Be    extractionLanguageFilterOptions    lang
    Wait Until Element Is Visible    ${ReloadBadge}
    Select From List By Index    extractionLanguageFilterOptions    3
    List Selection Should Be    extractionLanguageFilterOptions    lang-agn
    Wait Until Element Is Visible    ${ReloadBadge}

Find and open Collision resolution option
    [Documentation]    Click Option, then Collision resolution, select every option and verify if Reload Badge appears/disappears
    [Tags]    options

    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}
    Select From List By Index    collisionResolutionOptions    0
    List Selection Should Be    collisionResolutionOptions    overwrite
    Wait Until Element Is Not Visible    ${ReloadBadge}
    Select From List By Index    collisionResolutionOptions    1
    List Selection Should Be    collisionResolutionOptions    rename
    Wait Until Element Is Visible    ${ReloadBadge}
    Select From List By Index    collisionResolutionOptions    2
    List Selection Should Be    collisionResolutionOptions    rename-all
    Wait Until Element Is Visible    ${ReloadBadge}
    Select From List By Index    collisionResolutionOptions    3
    List Selection Should Be    collisionResolutionOptions    error
    Wait Until Element Is Visible    ${ReloadBadge}

Verify Output log to a file option
    [Documentation]    Verify Output logs to a file option
    [Tags]    options
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${file_4mb}[archive_name].zip
    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OutputLogsSwitch}
    Click Element    ${OutputLogsSwitch}
    Wait Until Element Is Visible    ${DownloadLogsButton}
    Click Add Files Button
    Ubuntu Upload Test File    ${file_4mb}[path]
    Click Load Button
    Wait Until Keyword Succeeds  5s  1s  Click Element  ${DownloadLogsButton}
    Switch Window    new
    Wait Until Element Is Visible    ${OpeningFileText}

Verify Collision resolution functionality
    [Documentation]    Verify Collision resolution functionality
    [Tags]    options
    # the test fails as per bug RND201-240
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${collisions}[archive_name].zip
    Click Add Files Button
    Ubuntu Upload Test File    ${collisions}[path]
    Click Load Button
    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}
    Select From List By Index    extractionLanguageFilterOptions    1
    List Selection Should Be    extractionLanguageFilterOptions    all
    Select From List By Index    collisionResolutionOptions    0
    List Selection Should Be    collisionResolutionOptions    overwrite
    Click Load Button
    Click Extract And Save Button    ${extraction_timeout}
    Wait Until Created    ${downloaded_file_path}
    Validate and Unzip Test File    ${downloaded_file_path}
    ${ListFiles}  List Files In Directory   ${DOWNLOAD_PATH}${collisions}[archive_name]/app
    Should Be Equal As Strings     ${ListFiles}    ['MyProg.chm', 'MyProg.exe', 'Readme.txt'] 
    Remove File    ${downloaded_file_path}
    Remove Directory    ${DOWNLOAD_PATH}${collisions}[archive_name]    True
    Select From List By Index    extractionLanguageFilterOptions    1
    List Selection Should Be    extractionLanguageFilterOptions    all
    Select From List By Index    collisionResolutionOptions    1
    List Selection Should Be    collisionResolutionOptions    rename
    Click Load Button
    Click Extract And Save Button    ${extraction_timeout}
    Wait Until Created    ${downloaded_file_path}
    Validate and Unzip Test File    ${downloaded_file_path}
    ${ListFiles}  List Files In Directory   ${DOWNLOAD_PATH}${collisions}[archive_name]/app
    Should Be Equal As Strings     ${ListFiles}    ['MyProg.chm', 'MyProg.exe', 'Readme.txt', 'Readme.txt#help@32bit', 'Readme.txt#readme@64bit', 'Readme.txt#readme@de', 'Readme.txt#readme@nl', 'Readme.txt$0readme@64bit']
    Remove File    ${downloaded_file_path}
    Remove Directory    ${DOWNLOAD_PATH}${collisions}[archive_name]    True
    Select From List By Index    extractionLanguageFilterOptions    1
    List Selection Should Be    extractionLanguageFilterOptions    all
    Select From List By Index    collisionResolutionOptions    2
    List Selection Should Be    collisionResolutionOptions    rename-all
    Click Load Button
    Click Extract And Save Button    ${extraction_timeout}
    Wait Until Created    ${downloaded_file_path}
    Validate and Unzip Test File    ${downloaded_file_path}
    ${ListFiles}  List Files In Directory   ${DOWNLOAD_PATH}${collisions}[archive_name]/app
    Should Be Equal As Strings     ${ListFiles}    ['MyProg.chm', 'MyProg.exe', 'Readme.txt#help@32bit', 'Readme.txt#readme@64bit', 'Readme.txt#readme@de', 'Readme.txt#readme@nl', 'Readme.txt$0readme@64bit', 'Readme.txt$1readme@64bit']
    Remove File    ${downloaded_file_path}
    Remove Directory    ${DOWNLOAD_PATH}${collisions}[archive_name]    True
    Select From List By Index    collisionResolutionOptions    3
    List Selection Should Be    collisionResolutionOptions    error
    Click Load Button
    Click Element    ${ExtractAndSaveButton}
    Wait Until Element Is Visible    ${ErrorText}