*** Settings ***
Documentation       Website header Tests

Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Resource            src/page_objects/keywords/ubuntu.robot
Resource            src/test_files/test_files.resource
Library             src/page_objects/libraries/browser_lib.py

Suite Setup         Prepare Test Environment
Test Setup          Prepare For Test
Test Teardown       Clean After Test


*** Test Cases ***
Find and verify header properties
    [Documentation]    Find and verify header name and image source
    [Tags]    websiteheader

    Page Should Contain Image    img/icon_64.png
    Page Should Contain Element    //span[contains(text(),"Innoextract wasm")]
