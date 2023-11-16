*** Settings ***
Documentation    Init file with suite setup and teardown methods

Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    src/page_objects/libraries/browser_lib.py

Variables    src/page_objects/locators/locators.py
Variables    variables.py

Suite Setup    Run Keywords
...    Prepare Test Environment
...    AND
...    Prepare For Test
...    AND
...    Check OS And Create Variable

Suite Teardown    Run Keyword    Clean After Suite


*** Keywords ***
Prepare Test Environment
    Log To Console    Cleaning ./output
    Remove Files    ./output/selenium*    ./output/geckodriver*
    Remove Directory    ./output/tmp    recursive=${True}

Prepare For Test
    ${DOWNLOAD_PATH}    Create Unique Download Path
    Set Global Variable    ${DOWNLOAD_PATH}
    ${profile}    create_profile    ${DOWNLOAD_PATH}
    Opening Browser    ${home_page_path}    ${browser}    ${profile}

Clean After Suite
    Close Browser
    Remove Directory    /tmp/output    recursive=${True}

Opening Browser
    [Arguments]    ${site_url}    ${browser}    ${profile}
    Open Browser    ${site_url}    ${browser}    ff_profile_dir=${profile}    service_log_path=./output/geckodriver-1.log
    Wait Until Element Is Visible    ${InputTitle}    timeout=5
    Log    URL open: ${site_url}    console=yes

Create Unique Download Path
    ${random_string}    Generate Random String    20
    # ${path}    Catenate    SEPARATOR=/    ${CURDIR}/../../../output/tmp    ${random_string}/
    ${path}    Catenate    SEPARATOR=/    /tmp/output    ${random_string}/
    Log    \nUnique download path created: ${path}    console=yes
    RETURN    ${path}

Check OS And Create Variable
    ${CURRENT_OS}    Evaluate    platform.system()    platform
    Set Global Variable    ${CURRENT_OS}
