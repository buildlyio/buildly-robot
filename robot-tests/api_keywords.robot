*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String
Resource        variables.robot


*** Keywords ***

Make Get Request
    [Arguments]   ${API_URL}  ${PATH}  ${ID}=${EMPTY}
    ${headers}=  Create Dictionary   Authorization=JWT ${JWT}
    Create Session  API  ${API_URL}    headers=${headers}
    ${resp}=     Get Request  API  ${PATH}${ID}
    Set Global Variable    ${RESPONSE}    ${resp}

Make Post Request
    [Arguments]   ${API_URL}  ${PATH}   ${DATA}  ${CONTENT_TYPE}=application/json
    ${headers}=  Create Dictionary   Authorization=JWT ${JWT}   Content-type=${CONTENT_TYPE}
    Create Session  API  ${API_URL}    headers=${headers}
    ${resp}=     Post Request  API  ${PATH}   data=${DATA}
    Set Global Variable    ${RESPONSE}    ${resp}

Make Put Request
    [Arguments]   ${API_URL}  ${PATH}  ${ID}  ${DATA}  ${CONTENT_TYPE}=application/json
    ${headers}=  Create Dictionary   Authorization=JWT ${JWT}   Content-type=${CONTENT_TYPE}
    Create Session  API  ${API_URL}    headers=${headers}
    ${resp}=     Put Request  API  ${PATH}${ID}   data=${DATA}
    Set Global Variable  ${RESPONSE}  ${resp}

Make Patch Request
    [Arguments]   ${API_URL}  ${PATH}   ${ID}  ${DATA}  ${CONTENT_TYPE}=application/json
    ${headers}=  Create Dictionary   Authorization=JWT ${JWT}   Content-type=${CONTENT_TYPE}
    Create Session  API  ${API_URL}    headers=${headers}
    ${resp}=     Patch Request  API  ${PATH}${ID}   data=${DATA}
    Set Global Variable  ${RESPONSE}  ${resp}

Make Delete Request
    [Arguments]   ${API_URL}  ${PATH}  ${ID}  ${CONTENT_TYPE}=application/json
    ${headers}=  Create Dictionary   Authorization=JWT ${JWT}   Content-type=${CONTENT_TYPE}
    Create Session  API  ${API_URL}    headers=${headers}
    ${resp}=     Delete Request  API  ${PATH}${ID}
    Set Global Variable  ${RESPONSE}  ${resp}

Make Post Request with File
    [Arguments]   ${API_URL}  ${PATH}   ${DATA}  ${FILE}
    ${headers}=  Create Dictionary   Authorization=JWT ${JWT}
    Create Session  API  ${API_URL}    headers=${headers}
    ${resp}=     Post Request  API  ${PATH}   data=${DATA}  files=${FILE}
    Set Global Variable    ${RESPONSE}    ${resp}