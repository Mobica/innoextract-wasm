*** Settings ***
Documentation       Website footer Tests

Library             SeleniumLibrary
Library             String
Resource            src/page_objects/keywords/common.robot
Resource            src/page_objects/keywords/home_page.robot
Resource            src/page_objects/keywords/ubuntu.robot
Resource            src/test_files/test_files.resource
Library             src/page_objects/libraries/browser_lib.py

*** Test Cases ***
Find and open About page
    [Documentation]    Click button About and check if subpage is opened
    [Tags]    websitefooter
    Click Element    ${AboutButton}
    Wait Until Element Is Visible    ${AboutSubpageText}

Find and open Known Issues page
    [Documentation]    Click button Known Issues and check if subpage is opened
    [Tags]    websitefooter
    Click Element    ${KnownIssuesButton}
    Wait Until Element Is Visible    ${KnownIssuesText}

Find and open Open source technologies page
    [Documentation]    Click button Open source technologies and check if subpage is opened
    [Tags]    websitefooter

    Click Element    ${OpenSourceTechnologiesButton}
    Wait Until Element Is Visible    ${OpenSourceTechnologiesText}

Find and open Github repository page
    [Documentation]    Click button Github repository and check if subpage is opened
    [Tags]    websitefooter

    Click Element    ${GithubRepository}
    Switch Window    new
    Location Should Be    https://github.com/Mobica/innoextract-wasm

Find and open Dark mode page, check background is changed
    [Documentation]    Click button Dark mode and check if background is changed to dark, then click Light mode and change is background colour is changed to ligh
    [Tags]    websitefooter

    Click Element    ${ChangeThemeButton}
    ${currentTheme}    Get Element Attribute    tag:html    data-bs-theme
    Should Be Equal As Strings    ${currentTheme}    dark
    Click Element    ${ChangeThemeButton}
    ${currentTheme}    Get Element Attribute    tag:html    data-bs-theme
    Should Be Equal As Strings    ${currentTheme}    light
