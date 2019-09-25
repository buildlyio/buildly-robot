*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String
Resource        ../variables.robot
Resource        ../api_keywords.robot
Resource        variables.robot

*** Keywords ***
Request GET /profiletypes from location service
    Make Get Request    ${LOCATION_API_BASE_URL}    /profiletypes/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

Request POST /profiletypes from location service
    Make Post Request    ${LOCATION_API_BASE_URL}    /profiletypes/    ${DATA_PROFILETYPES}
    LOG  ${RESPONSE.content}

Response code should be 201
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${ID}  ${JSON["id"]}

Request DELETE /profiletypes from location Service
    Make Delete Request    ${LOCATION_API_BASE_URL}    /profiletypes/    ${ID}
    LOG  ${RESPONSE.content}

Response code should be 204 and profileType should be deleted
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
    Make Get Request    ${LOCATION_API_BASE_URL}     /profiletypes/
    ${GET_ID}=    Create List
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    FOR    ${ELEMENT}    IN    @{JSON["results"]}
        Append To List    ${GET_ID}  ${ELEMENT["id"]}
    END
    LOG   ${GET_ID}
    List Should Not Contain Value    ${GET_ID}    ${ID}

Request PUT /profiletypes from location Service
    Make Put Request    ${LOCATION_API_BASE_URL}    /profiletypes/    ${ID}    ${DATA_PROFILETYPES_FOR_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PROFILETYPES_FOR_PUT}    ${NAME}

Request GET /profiletypes/ID from location service
    Make Get Request    ${LOCATION_API_BASE_URL}    /profiletypes/    ID=${ID}
    LOG  ${RESPONSE.content}

When Request PATCH /profiletypes from location Service
    Make Patch Request    ${LOCATION_API_BASE_URL}    /profiletypes/    ${ID}    ${DATA_PROFILETYPES_FOR_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PROFILETYPES_FOR_PATCH}    ${NAME}
