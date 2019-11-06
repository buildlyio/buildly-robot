*** Settings ***
Resource        ../keywords.robot
Resource        siteprofile_keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Location Service Siteprofiles

*** Test Cases ***
Location Service Get Request for Siteprofile should work

    Given I am authenticated api user
    When Request GET /Siteprofile from location service
    Then Response code should be 200

Location Service Post Request for Siteprofile should work

    Given I am authenticated api user
    When Created profileType
    And Request POST /Siteprofile from location service
    Then Response code should be 201 and created with correct profileType

Location Service PUT Request for Siteprofile should work

    Given I am authenticated api user
    When Request PUT /Siteprofile from location Service
    Then Response code should be 200 and name value should be changed for PUT

Location Service GET Request with UUID for Siteprofile should work
    Given I am authenticated api user
    When Request GET /siteprofiles/UUID from location service
    Then Response code should be 200

Location Service PATCH Request for Siteprofile should work

    Given I am authenticated api user
    When Request PATCH /Siteprofile from location Service
    Then Response code should be 200 and name value should be changed for PATCH

Location Service DELETE Request for Siteprofile should work

    Given I am authenticated api user
    When Request DELETE /Siteprofile from location Service
    Then Response code should be 204 and Siteprofile should be deleted
