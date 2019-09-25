*** Settings ***
Resource        ../keywords.robot
Resource        keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Document Service

*** Test Cases ***
Documents Service GET Request should work
    Given I am authenticated api user
    When Request GET /documents from Documents Service
    Then Response code should be 200

Documents Service POST Request should work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request POST /documents from Documents Service
    Then Response code should be 201

Documents Service PUT Request should work
    [Tags]  Quarantine
    # There is an issue for PUT and PATCH request on Document Service
    Given I am authenticated api user
    When Request PUT /documents from Documents Service
    Then Response code should be 200 and name value should be changed for PUT

Documents Service GET Request with ID should work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request GET /documents/id from Documents Service
    Then Response code should be 200

Documents Service PATCH Request should work
    [Tags]  Quarantine
    # There is an issue for PUT and PATCH request on Document Service
    Given I am authenticated api user
    When Request PATCH /documents from Documents Service
    Then Response code should be 200 and name value should be changed for PATCH

Documents Service GET Request with ID for file should work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request GET /file/id from Documents Service
    Then Response code should be 200

Documents Service GET Request with ID for thumbnail should work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request GET /thumbnail/id from Documents Service
    Then Response code should be 200

Documents Service POST Request with Long Name should not work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request POST /documents from Documents Service with Long File Name
    Then Response code should be 500

Documents Service POST Request with Big File Size should not work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request POST /documents from Documents Service with Big File Size
    Then Response code should be 413

Documents Service DELETE Request should work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request DELETE /documents from Documents Service
    Then Response code should be 204 and Document should be deleted
