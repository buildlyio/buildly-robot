*** Settings ***
Library     RequestsLibrary
Resource     ../variables.robot
Resource     ../api_keywords.robot

*** Keywords ***

Request GET /appointment from CRM Service
    Make Get Request    ${CRM_API_BASE_URL}    /appointment/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

Request POST /appointment from CRM Service
    Creating Variables for Datas
    Make Post Request    ${CRM_API_BASE_URL}    /appointment/    DATA={"name": "Postmán appöintment ${RANDOM_NUMBER}","start_date": "${TIMESTAMP_NOW}","end_date": "${TIMESTAMP_FUTURE}","type": ["technician"],"address": "Fritschestraße 31, 10585 Berlin, Germany"}
    LOG  ${RESPONSE.content}

Response code should be 201
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${ID}  ${JSON["uuid"]}

Request PUT /appointment from CRM Service
    Set Global Variable    ${DATA_PUT}    {"name": "PUT appöintment ${RANDOM_NUMBER}","start_date": "${TIMESTAMP_NOW}","end_date": "${TIMESTAMP_FUTURE}","type": ["technician"],"address": "Fritschestraße 31, 10585 Berlin, Germany"}
    Make Put Request    ${CRM_API_BASE_URL}    /appointment/    ${ID}    DATA=${DATA_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PUT}    ${NAME}

Request GET /appointment/id from CRM Service
    Make Get Request    ${CRM_API_BASE_URL}    /appointment/   ID=${ID}
    LOG  ${RESPONSE.content}

Request PATCH /appointment from CRM Service
    Set Global Variable    ${DATA_PATCH}    {"name": "PATCH appöintment ${RANDOM_NUMBER}","start_date": "${TIMESTAMP_NOW}","end_date": "${TIMESTAMP_FUTURE}","type": ["technician"],"address": "Fritschestraße 31, 10585 Berlin, Germany"}
    Make Patch Request    ${CRM_API_BASE_URL}    /appointment/    ${ID}    DATA=${DATA_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PATCH}    ${NAME}

Request DELETE /appointment from CRM Service
    Make Delete Request    ${CRM_API_BASE_URL}    /appointment/    ${ID}
    LOG  ${RESPONSE.content}

Response code should be 204 and Appointment should be deleted
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
    Make Get Request    ${CRM_API_BASE_URL}    /appointment/
    ${GET_ID}=    Create List
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    FOR    ${ELEMENT}    IN    @{JSON["results"]}
        Append To List    ${GET_ID}  ${ELEMENT["id"]}
    END
    LOG   ${GET_ID}
    List Should Not Contain Value    ${GET_ID}    ${ID}

Creating Variables for Datas
    ${NOW}=       Evaluate    datetime.datetime.now().isoformat()   modules=datetime
    Set Global Variable    ${TIMESTAMP_NOW}    ${NOW}
    ${FUTURE}=       Evaluate    (datetime.datetime.now()+ datetime.timedelta(minutes=30)).isoformat()   modules=datetime
    Set Global Variable    ${TIMESTAMP_FUTURE}    ${FUTURE}
    ${RANDOM}=      Evaluate    random.randint(0, 100)   modules=random
    Set Global Variable    ${RANDOM_NUMBER}    ${RANDOM}
