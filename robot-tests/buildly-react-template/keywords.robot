*** Settings ***
Library         SeleniumLibrary
Library         String
Library         RequestsLibrary
Library         Collections
Library         BuiltIn

*** Keywords ***
##### AUTHENTIFICATION #####
browser is opened to Buildly-React-Template URL
    Go To    ${BUILDLY_REACT_TEMPLATE_BASE_URL}
    ${status}=    Run Keyword And Ignore Error    Wait Until Page Contains    Login   10
    Log  ${status}
    Run Keyword If    'FAIL' in '''${status}'''    Reload Page
    Run Keyword If    'FAIL' in '''${status}'''    Wait Until Page Contains    Login   10

a new user is registered
    Click Link    /register
    Wait Until Page Contains    Register    10
    ${name}=  Generate Random Name
    Set Global Variable    ${NEW_USER_NAME}    ${name}
    ${password}=  Generate Random Name
    Set Global Variable    ${NEW_USER_PASSWORD}    ${password}
    Input Text    //input[@placeholder='Enter email']    ${NEW_USER_NAME}@example.com
    Input Text    //input[@placeholder='Enter username']    ${NEW_USER_NAME}
    Input Text    //input[@placeholder='Enter password']    ${NEW_USER_PASSWORD}
    Input Text    //input[@placeholder='Enter organization name']    ${NEW_USER_NAME}-org
    Input Text    //input[@placeholder='Enter first name']    ${NEW_USER_NAME}
    Input Text    //input[@placeholder='Enter last name']    Robot
    Click Button    Register

the user can login 
    Go To    ${BUILDLY_REACT_TEMPLATE_BASE_URL}
    Wait Until Page Contains    Login   10
    Location Should Contain    login
    Input Text    //input[@placeholder='Enter username']    ${NEW_USER_NAME}
    Input Text    //input[@placeholder='Enter password']    ${NEW_USER_PASSWORD}
    Click Button    Login
    Wait Until Page Contains    My App    10



