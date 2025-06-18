Feature: Login Feature
# feature files can have multiple scenarios/ user stories if they all fit together

#  Background:
#    Given The user is on the Login Page
#    And the login page is fully loading

  Scenario: Valid Login
    Given The user is on the Login Page
    When The user enters a valid username and password
    And The user clicks on the login button
    Then The user should be logged in successfully

  Scenario: Invalid Login
    Given The user is on the Login Page
    When The user enters an invalid username and password
    And the user clicks on the login button
    Then the user should get an error message

  Scenario Outline: Invalid Login
    When The user enters an invalid "<username>" and "<password>"
    And the user clicks on the login button
    Then the user should get an error message

    Examples:
    | username | password |
    | invalidUsername| invalidPassword |
    |validUsername| invalidPassword |
    |invalidUsername| validPassword |