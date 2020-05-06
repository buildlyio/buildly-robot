*** Settings ***
Resource        ../keywords.robot
Resource        keywords.robot
Resource        variables.robot
Resource        ../variables.robot
Suite Setup     Init
Suite Teardown  Teardown Actions
Documentation   Application Login

*** Test Cases ***
Register new user
    GIVEN browser is opened to Buildly-React-Template url 
    WHEN a new user is registered
    THEN the user can login 


