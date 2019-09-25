*** Settings ***
Resource        ../keywords.robot
Resource        contact_keywords.robot
Suite Setup     Set environment

Documentation   API Tests for CRM service Contacts

*** Test Cases ***

CRM Service GET Request for Contact should work

    Given I am authenticated api user
    When Request GET /contact from CRM Service
    Then Response code should be 200

CRM Service POST Request for Contact should work

    Given I am authenticated api user
    When Request POST /contact from CRM Service
    Then Response code should be 201

CRM Service PUT Request for Contact should work

    Given I am authenticated api user
    When Request PUT /contact from CRM Service
    Then Response code should be 200 and name value should be changed for PUT

CRM Service GET Request with ID for Contact should work

    Given I am authenticated api user
    When Request GET /contact/id from CRM Service
    Then Response code should be 200

CRM Service PATCH Request for Contact should work

    Given I am authenticated api user
    When Request PATCH /contact from CRM Service
    Then Response code should be 200 and name value should be changed for PATCH

CRM Service DELETE Request for Contact should work

    Given I am authenticated api user
    When Request DELETE /contact from CRM Service
    Then Response code should be 204
