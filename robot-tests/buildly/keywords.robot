*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Resource        ../variables.robot
Resource        ../api_keywords.robot
Resource        variables.robot

*** Keywords ***
fetching user list
    Make Get Request    ${BUILDLY_BASE_URL}     /coreuser/
    LOG  ${RESPONSE.json()}
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

list of all users contains test user
    ${resp-string}=    Convert To String    ${RESPONSE.json()}
    Should Contain    ${resp-string}    admin

Request GET /Groups from Buildly
    Make Get Request    ${BUILDLY_BASE_URL}    /coregroups/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
