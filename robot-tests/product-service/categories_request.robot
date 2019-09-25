*** Settings ***
Resource        ../keywords.robot
Resource        categories_keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Product Service Categories

*** Test Cases ***

Product Service GET Request for Categories should work
    Given I am authenticated api user
    When Request GET /Categories from Product service
    Then Response code should be 200

Product Service POST Request for Categories should work
    Given I am authenticated api user
    When Request POST /Categories from Product service
    Then Response code should be 201

Product Service PUT Request for Categories should work
    Given I am authenticated api user
    When Request PUT /Categories from Product Service
    Then Response code should be 200 and name value should be changed for PUT

Product Service GET Request with ID for Categories should work
    Given I am authenticated api user
    When Request GET /Categories/id from Product service
    Then Response code should be 200

Product Service PATCH Request for Categories should work
    Given I am authenticated api user
    When Request PATCH /Categories from Product Service
    Then Response code should be 200 and name value should be changed for PATCH

Product Service DELETE Request for Categories should work
    Given I am authenticated api user
    When Request DELETE /Categories from Product Service
    Then Response code should be 204 and Categories should be deleted
