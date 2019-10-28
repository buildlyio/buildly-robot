*** Settings ***
Resource        ../keywords.robot
Resource        keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Bifrost

*** Test Cases ***

Bifrost Service GET Request for Groups should work
    [Tags]  Quarantine
    Given I am authenticated api user
    When Request GET /Groups from Bifrost
    Then Response code should be 200
