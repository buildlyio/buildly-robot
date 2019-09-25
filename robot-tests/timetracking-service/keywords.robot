*** Settings ***
Library     RequestsLibrary
Resource    ../variables.robot
Resource    ../api_keywords.robot
Resource    ../crm-service/appointment_keywords.robot

*** Keywords ***
Requested timetracking service time-event with 100 UUIDs
    ${uuid} =    Set Variable    bf2648d6-2325-4f12-ae03-a16af0698d42,
    Make Get Request  ${TIMETRACKING_API_BASE_URL}     /time-event/?appointment_uuids=${uuid * 100}bf2648d6-2325-4f12-ae03-a16af0698d42
    LOG  ${RESPONSE.json()}

Request GET /time-event from Time-Tracking Service
    Make Get Request  ${TIMETRACKING_API_BASE_URL}  /time-event/

Request POST /time-event from Time-Tracking Service
    Create an Appointment for time-tracking
    Make Post Request  ${TIMETRACKING_API_BASE_URL}  /time-event/       DATA={"core_user_uuid": "acca56ea-e088-4cd8-bcfa-80545bab2f95","appointment_uuid": "${APP_ID}","time_logged_seconds": 0}

Request PUT /time-event from Time-Tracking Service
    Set Global Variable    ${DATA_PUT}    {"core_user_uuid": "acca56ea-e088-4cd8-bcfa-80545bab2f95","appointment_uuid": "${APP_ID}","time_logged_seconds": 120}
    Make Put Request    ${TIMETRACKING_API_BASE_URL}   /time-event/    ${ID}    DATA=${DATA_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and logged time value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${TIME}  ${JSON["time_logged_seconds"]}
    ${TIME}=    Convert To String   ${TIME}
    Should Contain    ${DATA_PUT}    ${TIME}

Request PATCH /time-event from Time-Tracking Service
    Set Global Variable    ${DATA_PATCH}    {"core_user_uuid": "acca56ea-e088-4cd8-bcfa-80545bab2f95","appointment_uuid": "${APP_ID}","time_logged_seconds": 180}
    Make Patch Request    ${TIMETRACKING_API_BASE_URL}   /time-event/    ${ID}    DATA=${DATA_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and logged time value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${TIME}  ${JSON["time_logged_seconds"]}
    ${TIME}=    Convert To String   ${TIME}
    Should Contain    ${DATA_PATCH}    ${TIME}

Request DELETE /time-event from Time-Tracking Service
    Make Delete Request    ${TIMETRACKING_API_BASE_URL}   /time-event/    ${ID}
    LOG  ${RESPONSE.content}
    Make Delete Request    ${CRM_API_BASE_URL}    /appointment/    ${APP_ID}

Response code should be 204 and time-event should be deleted
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
    Make Get Request    ${TIMETRACKING_API_BASE_URL}   /time-event/
    ${GET_ID}=    Create List
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    FOR    ${ELEMENT}    IN    @{JSON["results"]}
        Append To List    ${GET_ID}  ${ELEMENT["uuid"]}
    END
    LOG   ${GET_ID}
    List Should Not Contain Value    ${GET_ID}    ${ID}

Create an Appointment for time-tracking
    Request POST /appointment from CRM Service
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${APP_ID}  ${JSON["uuid"]}