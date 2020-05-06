*** Settings ***
Library         SeleniumLibrary
Library         String
Library         RequestsLibrary
Library         Collections

*** Keywords ***
##### AUTHENTIFICATION #####
browser is opened to Buildly-UI URL
    Go To    ${BUILDLY_UI_BASE_URL}
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
    Go To    ${BUILDLY_UI_BASE_URL}
    Wait Until Page Contains    Login   10
    Location Should Contain    login
    Input Text    //input[@placeholder='Enter username']    ${NEW_USER_NAME}
    Input Text    //input[@placeholder='Enter password']    ${NEW_USER_PASSWORD}
    Click Button    Login
    Wait Until Page Contains    My App    10


#### Verify the User management section ####
a new user can login as an admin
    Go To   ${BUILDLY_REACT_TEMPLATE_BASE_URL}
    Wait Until Page Contains    Login   10
    Location Should Contain     login
    Set Global Variable    ${NEW_USER_NAME}    admin
    Set Global Variable    ${NEW_USER_PASSWORD}     admin
    Input Text    //input[@placeholder='Enter username']    ${NEW_USER_NAME}
    Input Text    //input[@placeholder='Enter password']    ${NEW_USER_PASSWORD}
    Click Button    Login
    Wait Until Page Contains    My App    10
    Wait Until Page Contains    Profile   20
    Click Button    //button[@id='profile/users/current-users']


the user can manage current users section
    Go To  ${BUILDLY_REACT_TEMPLATE_BASE_URL}/app/profile/users/current-users 
    Page Should Contain Element     //h3[@class='profile__header__name']
    Page Should Contain Button      //button[@id='current-users']
    Page Should Contain Button      //button[@id='groups']
    Click Button  //*[@id="groups"]
    Wait Until Page Contains   Create a group   10
    Page Should Contain Button  //button[.='Create a group']
    Element Text Should Be  //*[@id="root"]/div/div/div/div[2]/div[2]/div/div[1]/div[3]/div/div[2]/div[2]/div[1]/div[1]/div/div/div/h4  Admins
    Element Text Should Be  //*[@id="root"]/div/div/div/div[2]/div[2]/div/div[1]/div[3]/div/div[2]/div[2]/div[2]/div[1]/div/div/div/h4  Global Admin
    Click Button  //button[.='Create a group']