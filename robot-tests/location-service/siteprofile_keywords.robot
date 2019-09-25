*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String
Resource        ../variables.robot
Resource        ../api_keywords.robot
Resource        variables.robot

*** Keywords ***

Created profileType
    Make Post Request    ${LOCATION_API_BASE_URL}    /profiletypes/    ${DATA_PROFILETYPES}
    LOG  ${RESPONSE.content}
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${ID}  ${JSON["id"]}

Request GET /Siteprofile from location service
    Make Get Request    ${LOCATION_API_BASE_URL}    /siteprofiles/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

Request POST /Siteprofile from location service
    Make Post Request    ${LOCATION_API_BASE_URL}    /siteprofiles/    DATA={"name": "SitëProfile Postmáñ","address_line1": "Schönstrasse 44","address_line2": "10115 Berlin","postcode": "10115","city": "Berlin","country": "DE", "profiletype": "${ID}"}
    LOG  ${RESPONSE.content}

Response code should be 201 and created with correct profileType
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${PROFILETYPE}  ${JSON["profiletype"]}
    Should Be Equal As Strings  ${PROFILETYPE}  ${ID}
    Set Global Variable  ${UUID}  ${JSON["uuid"]}

Request PUT /Siteprofile from location Service
    Make Put Request    ${LOCATION_API_BASE_URL}    /siteprofiles/    ${UUID}    ${DATA_SITEPROFILE_FOR_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${CITY}  ${JSON["city"]}
    Should Contain    ${DATA_SITEPROFILE_FOR_PUT}    ${CITY}

Request GET /siteprofiles/UUID from location service
    Make Get Request    ${LOCATION_API_BASE_URL}    /siteprofiles/  ID=${UUID}
    LOG  ${RESPONSE.content}

Request PATCH /Siteprofile from location Service
    Make Patch Request    ${LOCATION_API_BASE_URL}     /siteprofiles/    ${UUID}    ${DATA_SITEPROFILE_FOR_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_SITEPROFILE_FOR_PATCH}    ${NAME}

Request DELETE /Siteprofile from location Service
    Make Delete Request    ${LOCATION_API_BASE_URL}    /siteprofiles/    ${UUID}
    LOG  ${RESPONSE.content}

Response code should be 204 and Siteprofile should be deleted
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
    Make Get Request    ${LOCATION_API_BASE_URL}    /siteprofiles/
    ${GET_UUID}=    Create List
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    FOR    ${ELEMENT}    IN    @{JSON["results"]}
        Append To List    ${GET_UUID}  ${ELEMENT["uuid"]}
    END
    List Should Not Contain Value    ${GET_UUID}    ${UUID}
    Make Delete Request    ${LOCATION_API_BASE_URL}    /profiletypes/    ${ID}
