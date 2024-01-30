*** Settings ***
Documentation       Smoke Tests

Library             OperatingSystem
Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Resource            src/test_files/test_files.resource
Library             src/page_objects/libraries/browser_lib.py

Test Teardown       Clean After Test


*** Test Cases ***
Extract and validate a large test file
    [Documentation]    Extract and validate a large test file
    [Tags]    daily    regression    large
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${large_file_15}[archive_name].zip
    # Add a file for extraction
    Click Add Files Button
    Upload Test File    ${large_file_15}[path]
    # Load the file
    Click Load Button
    Check If Log Console Contains    Opening "${large_file_15}[name]"
    Validate Output Description    ${large_file_15}[archive_name]
    Validate Output Archive File Size    ${large_file_15}[archive_size_bytes]
    Validate Output Archive Files Number    ${large_file_15}[files_in_archive]
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}
    # Extract and create a ZIP file
    Click Extract And Save Button    ${large_file_15}[extraction_time]
    Wait Until Created    ${downloaded_file_path}
    # Rename folder name
    ${downloaded_file_path_new_name}    Remove Spaces From File Name    ${downloaded_file_path}
    # Unzip extracted ZIP file
    Validate and Unzip Test File    ${downloaded_file_path_new_name}
    # Validate output
    Check If Log Console Contains    "status":"Completed successfully"
    Check If Log Console Does Not Contain Errors
    Check If JS Console Does Not Contain Errors

Extract and compare directory and files tree
    [Documentation]    Extract and compare directory and files tree
    [Tags]    daily    regression    large
    # TODO: This test fails because of bug. One empty folder and 1one empty file are not in ZIP folder.
    # Either pattern folder will be adjusted or bug will be fixed
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${large_file_15}[archive_name].zip
    # Add a file for extraction
    Click Add Files Button
    Upload Test File    ${large_file_15}[path]
    # Load the file
    Click Load Button
    Check If Log Console Contains    Opening "${large_file_15}[name]"
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}
    # Extract and create a ZIP file
    Click Extract And Save Button    ${large_file_15}[extraction_time]
    Wait Until Created    ${downloaded_file_path}
    # Rename folder name
    ${downloaded_file_path_new_name}    Remove Spaces From File Name    ${downloaded_file_path}
    Unzip File    ${downloaded_file_path_new_name}
    ${unzipped_new_folder_name}    Remove Spaces From Directory Name    ${DOWNLOAD_PATH}${large_file_15}[archive_name]
    # Validate output
    Compare Directory And Files Tree    ${unzipped_new_folder_name}    ${large_file_15}[pattern_path]

Extract and compare files checksum
    [Documentation]    Extract and compare files checksums and sizes
    [Tags]    daily    regression    large
    # TODO: This test fails because of bug. One empty folder and 1one empty file are not in ZIP folder.
    # Either pattern folder will be adjusted or bug will be fixed
    ${downloaded_file_path}    Set Variable    ${DOWNLOAD_PATH}${large_file_15}[archive_name].zip
    # Add a file for extraction
    Click Add Files Button
    Upload Test File    ${large_file_15}[path]
    # Load the file
    Click Load Button
    Check If Log Console Contains    Opening "${large_file_15}[name]"
    Wait Until Page Does Not Contain Element    ${ExtractAndSaveDisabledButton}
    # Extract and create a ZIP file
    Click Extract And Save Button    ${large_file_15}[extraction_time]
    Wait Until Created    ${downloaded_file_path}
    # Rename folder name
    ${downloaded_file_path_new_name}    Replace String    ${downloaded_file_path}    ${space}    ${empty}
    Copy File    ${downloaded_file_path}    ${downloaded_file_path_new_name}
    Wait Until Created    ${downloaded_file_path_new_name}
    # Unzip extracted ZIP file
    Validate and Unzip Test File    ${downloaded_file_path_new_name}
    ${unzipped_new_folder_name}    Remove Spaces From Directory Name    ${DOWNLOAD_PATH}${large_file_15}[archive_name]
    # Validate output
    Compare Cheksum For Each File    ${unzipped_new_folder_name}    ${large_file_15}[pattern_path]
