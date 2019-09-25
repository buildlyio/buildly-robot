*** Settings ***
Resource        ../keywords.robot
Resource        products_keywords.robot
Suite Setup     Set environment

Documentation   API Tests for Product Service Products

*** Test Cases ***
Product Service Get Request for Product should work

    Given I am authenticated api user
    When Request GET /Product from Product service
    Then Response code should be 200

Product Service Post Request for Product should work

    Given I am authenticated api user
    When Request POST /Product from Product service
    Then Response code should be 201

Product Service PUT Request for Product should work

    Given I am authenticated api user
    When Request PUT /Product from Product Service
    Then Response code should be 200 and name value should be changed for PUT

Product Service GET Request with ID for Product should work
    Given I am authenticated api user
    When Request GET /products/id from Product service
    Then Response code should be 200

Product Service PATCH Request for Product should work

    Given I am authenticated api user
    When Request PATCH /Product from Product Service
    Then Response code should be 200 and name value should be changed for PATCH

Product Service DELETE Request for Product should work

    Given I am authenticated api user
    When Request DELETE /Product from Product Service
    Then Response code should be 204 and Product should be deleted
