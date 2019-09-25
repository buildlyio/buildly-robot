*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         OperatingSystem
Resource        ../api_keywords.robot
Resource        ../variables.robot
Resource        variables.robot

*** Keywords ***
Request GET /documents from Documents Service
    Make Get Request    ${DOCUMENTS_API_BASE_URL}    /documents/
    LOG  ${RESPONSE.content}

Response code should be 200
    Should Be Equal As Strings  ${RESPONSE.status_code}  200

Request POST /documents from Documents Service
    ${file_data}=    Get Binary File   Assets/test.jpeg
    ${files}=    Create Dictionary    file    ${file_data}
    ${DATA}=   evaluate  {'file_type':'jpeg', 'file_name':'test.jpeg'}
    Make Post Request with File    ${DOCUMENTS_API_BASE_URL}    /documents/    ${DATA}    ${files}

Response code should be 201
    Should Be Equal As Strings  ${RESPONSE.status_code}  201
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${ID}  ${JSON["id"]}

Request PUT /documents from Documents Service
    Set Global Variable    ${DATA_PUT}    {}
    Make Put Request    ${DOCUMENTS_API_BASE_URL}    /documents/    ${ID}    DATA=${DATA_PUT}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PUT
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PUT}    ${NAME}

Request GET /documents/id from Documents Service
    Make Get Request    ${DOCUMENTS_API_BASE_URL}    /documents/   ID=${ID}
    LOG  ${RESPONSE.content}

Request PATCH /documents from Documents Service
    Set Global Variable    ${DATA_PATCH}    {}
    Make Patch Request    ${DOCUMENTS_API_BASE_URL}    /documents/    ${ID}    DATA=${DATA_PATCH}
    LOG  ${RESPONSE.content}

Response code should be 200 and name value should be changed for PATCH
    Should Be Equal As Strings  ${RESPONSE.status_code}  200
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    Set Global Variable    ${NAME}  ${JSON["name"]}
    Should Contain    ${DATA_PATCH}    ${NAME}

Request DELETE /documents from Documents Service
    Make Delete Request    ${DOCUMENTS_API_BASE_URL}    /documents/    ${ID}
    LOG  ${RESPONSE.content}

Response code should be 204 and Document should be deleted
    Should Be Equal As Strings  ${RESPONSE.status_code}  204
    Make Get Request    ${DOCUMENTS_API_BASE_URL}    /documents/
    ${GET_ID}=    Create List
    ${JSON}=    Set Variable    ${RESPONSE.json()}
    FOR    ${ELEMENT}    IN    @{JSON["results"]}
        Append To List    ${GET_ID}  ${ELEMENT["id"]}
    END
    LOG   ${GET_ID}
    List Should Not Contain Value    ${GET_ID}    ${ID}

Request GET /file/id from Documents Service
    Make Get Request    ${DOCUMENTS_API_BASE_URL}    /file/   ID=${ID}
    LOG  ${RESPONSE.content}

Request GET /thumbnail/id from Documents Service
    Make Get Request    ${DOCUMENTS_API_BASE_URL}    /thumbnail/   ID=${ID}
    LOG  ${RESPONSE.content}

Request POST /documents from Documents Service with Long File Name
    ${file_data}=    Get Binary File    Assets/qwertyuiopasdfghjklzxcvbnmlkjhgfdsaqwertyujhgtrfdsewaqwertyuiopasdfghjklzxcvbnmlkjhgfdsaqwertyujhgtrfdsewaqwertyuiopasdfghjklzxcvbnmlkjhgfdsaqwertyujhgtrfdsewaqwertyuiopasdfghjklzxcvbnmlkjhgfdsaqqqq.jpeg
    ${files}=    Create Dictionary    file    ${file_data}
    ${DATA}=   evaluate  {'file_type':'jpeg', 'file_name':'qwertyuiopasdfghjklzxcvbnmlkjhgfdsaqwertyujhgtrfdsewaqwertyuiopasdfghjklzxcvbnmlkjhgfdsaqwertyujhgtrfdsewaqwertyuiopasdfghjklzxcvbnmlkjhgfdsaqwertyujhgtrfdsewaqwertyuiopasdfghjklzxcvbnmlkjhgfdsaqqqq.jpeg'}
    Set Log Level    NONE
    Make Post Request with File    ${DOCUMENTS_API_BASE_URL}    /documents/    ${DATA}    ${files}
    Set Log Level    INFO

Request POST /documents from Documents Service with Big File Size
    ${file_data}=    Get Binary File    Assets/SampleJPGImage_20mbmb.jpg
    ${files}=    Create Dictionary    file    ${file_data}
    ${DATA}=   evaluate  {'file_type':'jpg', 'file_name':'SampleJPGImage_20mbmb.jpg'}
    Set Log Level    NONE
    Make Post Request with File    ${DOCUMENTS_API_BASE_URL}    /documents/    ${DATA}    ${files}
    Set Log Level    INFO

Response code should be 500
    Should Be Equal As Strings  ${RESPONSE.status_code}  500

Response code should be 413
    Should Be Equal As Strings  ${RESPONSE.status_code}  413
