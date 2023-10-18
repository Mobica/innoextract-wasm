*** Settings ***
Documentation  Smoke Tests
Library        OperatingSystem
Library        SeleniumLibrary
Library        String
Resource       ../src/page_objects/keywords/common.robot
Resource       ../src/page_objects/keywords/home_page.robot
Resource       ../src/page_objects/keywords/ubuntu.robot
Resource       ../src/test_files/test_files.resource
Library        ../src/page_objects/libraries/browser_lib.py
Suite Setup   Prepare Test Environment
Test Setup    Prepare For Test
Test Teardown    Clean After Test


*** Test Cases ***
Find and open About page
    [documentation]  Click button About and check if subpage is opened
    [tags]  Regression
    #TODO: Find button About, clicks it and verifies if a list with some text dislays
    Click Element  ${AboutButton}
    Wait Until Element Is Visible   ${AboutSubpageText}    1

Find and open Known Issues page
    [documentation]  Click button Known Issues and check if subpage is opened
    [tags]  Regression
    #TODO: Find button Known Issues, clicks it and verifies if a list with some text dislays
    Click Element  ${KnownIssuesButton}
    Wait Until Element Is Visible  //div[@id="issues"]/ul/*
    
Find and open Open source technologies page
    [documentation]  Click button Open source technologies and check if subpage is opened
    [tags]  Regression
    #TODO: Find button Open source technologies, clicks it and verifies if a list with some text dislays
    Click Element  ${OpenSourceTechnologiesButton}
    Wait Until Element Is Visible  //div[@id="techs"]/ul/*

Find and open Github repository page
    [documentation]  Click button Github repository and check if subpage is opened
    [tags]  Regression
    Click Element       xpath=/html/body/div[2]/small/a[4]
    Wait Until Element Is Visible  xpath=/html


Find and open Dark mode page
    [documentation]  Click button Dark mode and check if background is changed to dark, then click Light mode and change is background colour is changed to light
    [tags]  Regression
    Click Element  ${ChangeThemeButton}

    ${variable}  Get Element Attribute    tag:html    data-bs-theme
    Should Be Equal As Strings    ${variable}  dark

    Click Element  ${ChangeThemeButton}

    ${variable}  Get Element Attribute    tag:html    data-bs-theme
    Should Be Equal As Strings    ${variable}  light