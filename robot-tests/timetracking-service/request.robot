*** Settings ***
Resource        ../keywords.robot
Resource        keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Time-Tracking Service

*** Test Cases ***
TimeTracking service list of time events with long URI
    Given I am authenticated api user
    When Requested timetracking service time-event with 100 UUIDs
    Then Response code should be 200

Time-Tracking Service GET Request should work
    Given I am authenticated api user
    When Request GET /time-event from Time-Tracking Service
    Then Response code should be 200

Time-Tracking Service POST Request should work
    Given I am authenticated api user
    When Request POST /time-event from Time-Tracking Service
    Then Response code should be 201

Time-Tracking Service PUT Request should work
    Given I am authenticated api user
    When Request PUT /time-event from Time-Tracking Service
    Then Response code should be 200 and logged time value should be changed for PUT

Time-Tracking Service PATCH Request should work
    Given I am authenticated api user
    When Request PATCH /time-event from Time-Tracking Service
    Then Response code should be 200 and logged time value should be changed for PATCH

Time-Tracking Service DELETE Request should work
    Given I am authenticated api user
    When Request DELETE /time-event from Time-Tracking Service
    Then Response code should be 204 and time-event should be deleted
