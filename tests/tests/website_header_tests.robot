Documentation       Website header Tests

Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Resource            src/page_objects/keywords/ubuntu.robot
Resource            src/test_files/test_files.resource
Library             src/page_objects/libraries/browser_lib.py

*** Test Cases ***
Find and verify header properties
    [Documentation]    Find and verify header name and image source
    [Tags]    websiteheader

    Page Should Contain Image    ${HeaderIcon}
    Page Should Contain Element    ${HeaderText}
