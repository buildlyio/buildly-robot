*** Settings ***
Resource        ../keywords.robot
Resource        appointment_keywords.robot
Suite Setup     Set environment

Documentation   API Tests for CRM service

*** Test Cases ***

CRM Service GET Request for Appointment should work

    Given I am authenticated api user
    When Request GET /appointment from CRM Service
    Then Response code should be 200

CRM Service POST Request for Appointment should work

    Given I am authenticated api user
    When Request POST /appointment from CRM Service
    Then Response code should be 201

CRM Service PUT Request for Appointment should work

    Given I am authenticated api user
    When Request PUT /appointment from CRM Service
    Then Response code should be 200 and name value should be changed for PUT

CRM Service GET Request with ID for Appointment should work

    Given I am authenticated api user
    When Request GET /appointment/id from CRM Service
    Then Response code should be 200

CRM Service PATCH Request for Appointment should work

    Given I am authenticated api user
    When Request PATCH /appointment from CRM Service
    Then Response code should be 200 and name value should be changed for PATCH

CRM Service DELETE Request for Appointment should work

    Given I am authenticated api user
    When Request DELETE /appointment from CRM Service
    Then Response code should be 204 and Appointment should be deleted
