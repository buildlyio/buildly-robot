*** Settings ***
Resource        ../keywords.robot
Resource        property_keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Product Service Property

*** Test Cases ***
Product Service Get Request for property should work

    Given I am authenticated api user
    When Request GET /property from Product Service
    Then Response code should be 200

Product Service Post Request for property should work

    Given I am authenticated api user
    When Request POST /property from Product service
    Then Response code should be 201

Product Service PUT Request for property should work

    Given I am authenticated api user
    When Request PUT /property from Product Service
    Then Response code should be 200 and name value should be changed for PUT

Product Service GET Request with ID for property should work
    Given I am authenticated api user
    When Request GET /property/id from Product service
    Then Response code should be 200

Product Service PATCH Request for property should work

    Given I am authenticated api user
    When Request PATCH /property from Product Service
    Then Response code should be 200 and name value should be changed for PATCH

Product Service DELETE Request for property should work

    Given I am authenticated api user
    When Request DELETE /property from Product Service
    Then Response code should be 204 and property should be deleted

Product Service Post Request for property with Product should work

    Given I am authenticated api user
    When Create Product
    And Request POST /property with product from Product service
    Then Response code should be 201
    And Request DELETE /property from Product Service
    Then Response code should be 204 and property should be deleted
