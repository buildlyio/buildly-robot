*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String
Resource        ../variables.robot
Resource        ../api_keywords.robot
Resource        variables.robot

*** Keywords ***

Request GET /Categories from Product service
    Make Get Request    ${PRODUCT_API_BASE_URL}    /categories/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

Request POST /Categories from Product service
    Make Post Request    ${PRODUCT_API_BASE_URL}    /categories/    ${DATA_CATEGORIES}
    LOG  ${RESPONSE.content}

Response code should be 201
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${ID}  ${JSON["uuid"]}

Request DELETE /Categories from Product Service
    Make Delete Request    ${PRODUCT_API_BASE_URL}    /categories/    ${ID}
    LOG  ${RESPONSE.content}

Response code should be 204 and Categories should be deleted
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
    Make Get Request    ${PRODUCT_API_BASE_URL}    /categories/
    ${GET_ID}=    Create List
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    FOR    ${ELEMENT}    IN    @{JSON}
        Append To List    ${GET_ID}  ${ELEMENT["uuid"]}
    END
    LOG   ${GET_ID}
    List Should Not Contain Value    ${GET_ID}    ${ID}

Request PUT /Categories from Product Service
    Make Put Request    ${PRODUCT_API_BASE_URL}    /categories/    ${ID}    ${DATA_CATEGORIES_FOR_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_CATEGORIES_FOR_PUT}    ${NAME}

Request GET /Categories/id from Product service
    Make Get Request    ${PRODUCT_API_BASE_URL}    /categories/   ID=${ID}
    LOG  ${RESPONSE.content}

Request PATCH /Categories from Product Service
    Make Patch Request    ${PRODUCT_API_BASE_URL}    /categories/    ${ID}    ${DATA_CATEGORIES_FOR_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_CATEGORIES_FOR_PATCH}    ${NAME}
