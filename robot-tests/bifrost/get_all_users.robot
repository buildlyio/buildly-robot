*** Settings ***
Library     Collections
Library     RequestsLibrary

Resource    variables.robot
Resource    keywords.robot
Resource    ../keywords.robot
Resource    ../variables.robot

Suite Setup     Set environment

*** Test Cases ***
Core User List
	GIVEN I am authenticated api user
	WHEN fetching user list
	THEN list of all users contains test user
