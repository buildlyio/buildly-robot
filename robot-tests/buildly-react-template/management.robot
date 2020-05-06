Resource        ../keywords.robot
Resource        keywords.robot
Resource        variables.robot
Resource        ../variables.robot
Suite Setup     Init
Suite Teardown  Teardown Actions
Documentation   Application Login

*** Test Cases ***
Verify the user management section
    GIVEN browser is opened to Buildly-React-Template url
    WHEN a new user can login as an admin
    THEN the user can manage current users section
 