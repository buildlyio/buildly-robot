*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String
Resource        ../variables.robot
Resource        variables.robot
Resource        ../api_keywords.robot

*** Keywords ***

Request GET /Product from Product service
    Make Get Request    ${PRODUCT_API_BASE_URL}    /products/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

Request POST /Product from Product service
    Make Post Request    ${PRODUCT_API_BASE_URL}    /products/    ${DATA_PRODUCT}
    LOG  ${RESPONSE.content}

Response code should be 201
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${UUID}  ${JSON["uuid"]}

Request PUT /Product from Product Service
    Make Put Request    ${PRODUCT_API_BASE_URL}    /products/    ${UUID}    ${DATA_PRODUCT_FOR_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PRODUCT_FOR_PUT}    ${NAME}

Request GET /products/id from Product service
    Make Get Request    ${PRODUCT_API_BASE_URL}    /products/  ID=${UUID}
    LOG  ${RESPONSE.content}

Request PATCH /Product from Product Service
    Make Patch Request    ${PRODUCT_API_BASE_URL}    /products/    ${UUID}    ${DATA_PRODUCT_FOR_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PRODUCT_FOR_PATCH}    ${NAME}

Request DELETE /Product from Product Service
    Make Delete Request    ${PRODUCT_API_BASE_URL}    /products/    ${UUID}
    LOG  ${RESPONSE.content}

Response code should be 204 and Product should be deleted
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
    Make Get Request    ${PRODUCT_API_BASE_URL}    /products/
    ${headers}=  Create Dictionary   Authorization=JWT ${JWT}
    ${GET_UUID}=    Create List
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    FOR    ${ELEMENT}    IN    @{JSON["results"]}
        Append To List    ${GET_UUID}  ${ELEMENT["uuid"]}
    END
    List Should Not Contain Value    ${GET_UUID}    ${UUID}
