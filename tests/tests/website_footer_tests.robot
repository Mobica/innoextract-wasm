*** Settings ***
Documentation       Website footer Tests

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
Find and open About page
    [tags]  WebsiteFooter
    [documentation]  Click button About and check if subpage is opened
    Click Element    ${AboutButton}
    Wait Until Element Is Visible    ${AboutSubpageText}    

Find and open Known Issues page
    [tags]  WebsiteFooter
    [documentation]  Click button Known Issues and check if subpage is opened
    Click Element    ${KnownIssuesButton}
    Wait Until Element Is Visible    ${KnownIssuesText}

Find and open Open source technologies page
    [documentation]  Click button Open source technologies and check if subpage is opened
    [tags]  WebsiteFooter

    Click Element    ${OpenSourceTechnologiesButton}
    Wait Until Element Is Visible    ${OpenSourceTechnologiesText}

Find and open Github repository page
    [documentation]  Click button Github repository and check if subpage is opened
    [tags]  WebsiteFooter

    Click Element    ${GithubRepository}
    Switch Window    new
    Location Should Be    https://github.com/Mobica/innoextract-wasm

Find and open Dark mode page, check background is changed
    [documentation]  Click button Dark mode and check if background is changed to dark, then click Light mode and change is background colour is changed to ligh
    [tags]  WebsiteFooter

    Click Element    ${ChangeThemeButton}
    ${currentTheme}    Get Element Attribute    tag:html    data-bs-theme
    Should Be Equal As Strings    ${currentTheme}    dark
    Click Element    ${ChangeThemeButton}
    ${variable}    Get Element Attribute    tag:html    data-bs-theme
    Should Be Equal As Strings    ${variable}    light
