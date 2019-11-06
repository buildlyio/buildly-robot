*** Settings ***
Resource        ../keywords.robot
Resource        keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Buildly

*** Test Cases ***

Buildly Service GET Request for Groups should work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request GET /Groups from Buildly
    Then Response code should be 200
