*** Settings ***
Library         SeleniumLibrary
Library         String
Library         RequestsLibrary
Library         Collections

*** Keywords ***
##### AUTHENTIFICATION #####
browser is opened to midgard angular url
    Go To    ${MIDGARD_ANGULAR_BASE_URL}
    ${status}=    Run Keyword And Ignore Error    Wait Until Page Contains    Login   10
    Log  ${status}
    Run Keyword If    'FAIL' in '''${status}'''    Reload Page
    Run Keyword If    'FAIL' in '''${status}'''    Wait Until Page Contains    Login   10

a new user is registered
    #Location Should Contain    login
    Click Link    /register
    Wait Until Page Contains    Sign Up    10
    ${name}=  Generate Random Name
    Set Global Variable    ${NEW_USER_NAME}    ${name}
    ${password}=  Generate Random Name
    Set Global Variable    ${NEW_USER_PASSWORD}    ${password}
    Input Text    //input[@placeholder='Email']    ${NEW_USER_NAME}@example.com
    Input Text    //input[@placeholder='Username']    ${NEW_USER_NAME}
    Input Text    //input[@placeholder='Password']    ${NEW_USER_PASSWORD}
    Input Text    //input[@placeholder='Retype your password']    ${NEW_USER_PASSWORD}
    Input Text    //input[@placeholder='Organization']    ${NEW_USER_NAME}-org
    Input Text    //input[@placeholder='First name']    ${NEW_USER_NAME}
    Input Text    //input[@placeholder='Last name']    Robot
    Wait Until Element Is Enabled    css:fj-button    10
    Click Element    css:fj-button

the user can login
    Wait Until Page Contains    Login   10
    Location Should Contain    login
    Input Text    //input[@placeholder='Username']    ${NEW_USER_NAME}
    Input Text    //input[@placeholder='Password']    ${NEW_USER_PASSWORD}
    Wait Until Element Is Enabled    css:fj-button    10
    Click Element    css:fj-button
    the user is logged in

the user is logged in
    Wait Until Page Contains    My Profile   10
