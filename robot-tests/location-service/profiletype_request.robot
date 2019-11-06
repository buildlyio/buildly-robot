*** Settings ***
Resource        ../keywords.robot
Resource        profiletype_keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Location Service Profiletype

*** Test Cases ***
Location Service Get Request for ProfileTypes should work

    Given I am authenticated api user
    When Request GET /profiletypes from location service
    Then Response code should be 200
    #When Request GET /profiletypes/{id} from crm service
    #Then Response code should be 200

Location Service Post Request for ProfileTypes should work

    Given I am authenticated api user
    When Request POST /profiletypes from location service
    Then Response code should be 201

Location Service PUT Request for ProfileTypes should work

    Given I am authenticated api user
    When Request PUT /profiletypes from location Service
    Then Response code should be 200 and name value should be changed for PUT

Location Service GET Request with ID for ProfileTypes should work
    Given I am authenticated api user
    When Request GET /profiletypes/ID from location service
    Then Response code should be 200

Location Service PATCH Request for ProfileTypes should work

    Given I am authenticated api user
    When Request PATCH /profiletypes from location Service
    Then Response code should be 200 and name value should be changed for PATCH

Location Service DELETE Request for ProfileTypes should work

    Given I am authenticated api user
    When Request DELETE /profiletypes from location Service
    Then Response code should be 204 and profileType should be deleted
