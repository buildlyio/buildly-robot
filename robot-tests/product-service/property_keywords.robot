*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String
Resource        ../variables.robot
Resource        variables.robot
Resource        ../api_keywords.robot

*** Keywords ***

Request GET /property from Product Service
    Make Get Request    ${PRODUCT_API_BASE_URL}    /property/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

Request POST /property from Product service
    Make Post Request    ${PRODUCT_API_BASE_URL}    /property/    ${DATA_PROPERTY}
    LOG  ${RESPONSE.content}

Response code should be 201
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable  ${ID}  ${JSON["uuid"]}

Request PUT /property from Product Service
    Make Put Request    ${PRODUCT_API_BASE_URL}    /property/    ${ID}    ${DATA_PROPERTY_FOR_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PROPERTY_FOR_PUT}    ${NAME}

Request GET /property/id from Product service
    Make Get Request    ${PRODUCT_API_BASE_URL}    /property/   ID=${ID}
    LOG  ${RESPONSE.content}

Request PATCH /property from Product Service
    Make Patch Request    ${PRODUCT_API_BASE_URL}    /property/    ${ID}    ${DATA_PROPERTY_FOR_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PROPERTY_FOR_PATCH}    ${NAME}

Request DELETE /property from Product Service
    Make Delete Request    ${PRODUCT_API_BASE_URL}    /property/    ${ID}
    LOG  ${RESPONSE.content}

Response code should be 204 and property should be deleted
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
    Make Get Request    ${PRODUCT_API_BASE_URL}    /property/
    ${GET_ID}=    Create List
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    FOR    ${ELEMENT}    IN    @{JSON}
        Append To List    ${GET_ID}  ${ELEMENT["uuid"]}
    END
    List Should Not Contain Value    ${GET_ID}    ${ID}

Create Product
    Make Post Request    ${PRODUCT_API_BASE_URL}    /products/    ${DATA_PRODUCT}
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${PRODUCT_ID}  ${JSON["uuid"]}

Request POST /property with product from Product service
    Make Post Request    ${PRODUCT_API_BASE_URL}    /property    DATA={"name": "Postmán Property", "value": "API", "product":"${PRODUCT_ID}"}
    LOG  ${RESPONSE.content}
