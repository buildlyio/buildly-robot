*** Settings ***
Library     RequestsLibrary
Resource     ../variables.robot
Resource     variables.robot
Resource     ../api_keywords.robot

*** Keywords ***

Request GET /contact from CRM Service
    Make Get Request    ${CRM_API_BASE_URL}    /contact/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

Request POST /contact from CRM Service
    Make Post Request    ${CRM_API_BASE_URL}    /contact/    DATA=${DATA_CONTACT}
    LOG  ${RESPONSE.content}

Response code should be 201
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${ID}  ${JSON["id"]}

Request PUT /contact from CRM Service
    Make Put Request    ${CRM_API_BASE_URL}    /contact/    ${ID}    DATA=${DATA_CONTACT_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["first_name"]}
    Should Contain    ${DATA_CONTACT_PUT}    ${NAME}

Request GET /contact/id from CRM Service
    Make Get Request    ${CRM_API_BASE_URL}    /contact/   ID=${ID}
    LOG  ${RESPONSE.content}

Request PATCH /contact from CRM Service
    Make Patch Request    ${CRM_API_BASE_URL}    /contact/    ${ID}    DATA=${DATA_CONTACT_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["first_name"]}
    Should Contain    ${DATA_CONTACT_PATCH}    ${NAME}

Request DELETE /contact from CRM Service
    Make Delete Request    ${CRM_API_BASE_URL}    /contact/    ${ID}
    LOG  ${RESPONSE.content}

Response code should be 204
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
