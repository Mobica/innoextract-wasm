*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Variables  ../locators/locators.py

*** Keywords ***
Ubuntu Upload Test File
    [Arguments]  ${file_path}
    OperatingSystem.Run    xdotool key ctrl+l
    Sleep    2s
    OperatingSystem.Run    xdotool type ${file_path}
    Sleep    2s
    OperatingSystem.Run    xdotool --window %1
    OperatingSystem.Run    xdotool key KP_Enter
    OperatingSystem.Run    xdotool key KP_Enter
    OperatingSystem.Run    xdotool --window %1
    Wait Until Element Is Enabled   ${StartButton}

File Select Is Visible
    ${current_window_id}    OperatingSystem.Run    xdotool getactivewindow
    ${current_window_title}    OperatingSystem.Run    xdotool getwindowname ${current_window_id}
    Should Be Equal As Strings    ${current_window_title}    File Upload