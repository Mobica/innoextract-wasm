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
${extraction_timeout}       60s


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

Enable Debug Output functionality test
    [Documentation]    Enable debug output functionality adds debug logs if selected
    [Tags]    options

    Click Add Files Button
    Upload Test File    ${file_4mb}[path]
    Click Load Button
    Check If Log Console Contains    Opening "${file_4mb}[name]"
    Validate Output Description    ${file_4mb}[archive_name]
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}
    Click Extract And Save Button    ${extraction_timeout}
    Validate File Details In Log Console    ${file_4mb}
    Check If Log Console Does Not Contain    loaded
    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${OptionsList}
    Click Element    ${EnableDebugSwitch}
    Click Load Button
    Check If Log Console Contains    Opening "${file_4mb}[name]"
    Validate Output Description    ${file_4mb}[archive_name]
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}
    Click Extract And Save Button    ${extraction_timeout}
    Validate File Details In Log Console    ${file_4mb}
    Check If Log Console Contains    loaded
    Wait Until Element Is Visible    ${ReloadBadge}

Verify Output log to a file option
    [Documentation]    Verify Output log to a file option
    [Tags]    options
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${file_4mb}[archive_name].zip
    Click Add Files Button
    Upload Test File    ${file_4mb}[path]
    Click Load Button
    Check If Log Console Contains    Opening "${file_4mb}[name]"
    Validate Output Description    ${file_4mb}[archive_name]
    Click Element    ${OptionsButton}
    Wait Until Element Is Visible    ${LogsButton}
    Click Element    ${OutputLogsSwitch}
    Wait Until Element Is Visible    ${DownloadLogsButton}
    Click Load Button
    Click Element    ${DownloadLogsButton}
    Switch Window    new
    Wait Until Element Is Visible    ${OpeningFileText}

Exclude temporary files functionality test
    [Documentation]    Exclude temporary files functionality removes tmp folder from loaded file
    [Tags]    options
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${test_setup}[archive_name].zip
    Click Add Files Button
    Upload Test File    ${test_setup}[path]
    Click Load Button
    Click Extract And Save Button    ${extraction_timeout}
    Wait Until Created    ${downloaded_file_path}
    Validate and Unzip Test File    ${downloaded_file_path}
    ${filesCount}    Count Items In Directory    ${DOWNLOAD_PATH}${test_setup}[archive_name]
    Should Be Equal As Integers    ${filesCount}    2
    Remove File    ${downloaded_file_path}
    Remove Directory    ${DOWNLOAD_PATH}${test_setup}[archive_name]    True
    Click Element    ${FilesList}
    Wait Until Element Is Visible    ${TemporaryFilesFolder}
    Click Element    ${OptionsButton}
    Click Element    ${ExcludeTemporaryFilesSwitch}
    Click Load Button
    Click Extract And Save Button    ${extraction_timeout}
    Wait Until Created    ${downloaded_file_path}
    Validate and Unzip Test File    ${DOWNLOAD_PATH}${test_setup}[archive_name].zip
    ${filesCount}    Count Items In Directory    ${DOWNLOAD_PATH}${test_setup}[archive_name]
    Should Be Equal As Integers    ${filesCount}    1
