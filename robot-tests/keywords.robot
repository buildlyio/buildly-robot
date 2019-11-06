*** Settings ***
Library    SeleniumLibrary
Library    ./get_selenium_browser_log.py
Library    Process

*** Variables ***
@{chrome_arguments}    --disable-infobars    --headless    --disable-gpu   --no-sandbox   --window-size=1920,1080
${HEADLESS_BROWSER_ENABLED}     True

*** Keywords ***
Init
    Set environment
    Run keyword if  ${HEADLESS_BROWSER_ENABLED}
    ...  Start Headless Browser
    ...  ELSE
    ...  Start Browser

Start Browser
    Open Browser  about:blank  browser=chrome
    Set Window Size    1920    1080
    Set Selenium Speed   0.5 seconds

Start Headless Browser
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}   add_argument    headless
    Call Method    ${chrome_options}   add_argument    disable-gpu
    ${options}=     Call Method     ${chrome_options}    to_capabilities

    ${chrome_options}=    Set Chrome Options
    ${mem}=    Run Process    free -h    shell=True
    Log    ${mem.stdout}
    Create Webdriver    Chrome    chrome_options=${chrome_options}

Set Chrome Options
    [Documentation]    Set Chrome options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    FOR    ${option}    IN    @{chrome_arguments}
        Call Method    ${options}    add_argument    ${option}
    END
    [Return]    ${options}

Teardown Actions
    @{browser_logs}=     Get Selenium Browser Log
    FOR    ${browser_log}    IN  @{browser_logs}
        Run keyword if    'SEVERE' in '''${browser_log}'''    Log    ${browser_log}    level=WARN
        ...    ELSE    Log    ${browser_log}
    END
    Close All Browsers

I am authenticated api user
    &{params}=   Create Dictionary   grant_type=password     username=${API_USER_USERNAME}     password=${API_USER_PASSWORD}
    &{headers}=   Create Dictionary   Content-type=application/x-www-form-urlencoded
    ${auth}=  Create List  ${CLIENT_ID}  ${CLIENT_SECRET}
    Create Session  kupfer  ${BUILDLY_BASE_URL}  auth=${auth}
    ${resp}=     Post Request  kupfer  /oauth/token/  data=${params}  headers=${headers}
    LOG  ${resp.json()}
    Set Global Variable  ${JWT}  ${resp.json()['access_token_jwt']}
    Should Be Equal As Strings  ${resp.status_code}  200

Set environment
    Run Keyword If    '${env}'!=''    Set environment to   ${env}

Set environment to
    [Arguments]    ${env}
    Set Global Variable    ${CLIENT_ID}                      ${CLIENT_ID_${env}}
    Set Global Variable    ${CLIENT_SECRET}                  ${CLIENT_SECRET_${env}}
    Set Global Variable    ${REGULAR_USER_USERNAME}          ${REGULAR_USER_USERNAME_${env}}
    Set Global Variable    ${REGULAR_USER_PASSWORD}          ${REGULAR_USER_PASSWORD_${env}}
    Set Global Variable    ${API_USER_USERNAME}              ${API_USER_USERNAME_${env}}
    Set Global Variable    ${API_USER_PASSWORD}              ${API_USER_PASSWORD_${env}}
    Set Global Variable    ${BUILDLY_UI_BASE_URL}            ${BUILDLY_UI_BASE_URL_${env}}
    Set Global Variable    ${BUILDLY_BASE_URL}               ${BUILDLY_BASE_URL_${env}}
    Set Global Variable    ${PRODUCT_API_BASE_URL}           ${PRODUCT_API_BASE_URL_${env}}
    Set Global Variable    ${LOCATION_API_BASE_URL}          ${LOCATION_API_BASE_URL_${env}}

Generate Random Name
    ${name}=  Generate Random String  8  	[LOWER]
    [RETURN]    ${name}
