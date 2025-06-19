Feature: Login Functionality

  Background:
    Given The user is on the Login Page

  Scenario Outline: Invalid Login
    When The user enters an invalid "<username>" and/or "<password>"
    And the user clicks on the login button
    Then the system should display a login error message

    Examples:
      | username | password |
      | invalidUsername| invalidPassword |
      |validUsername| invalidPassword |
      |invalidUsername| validPassword |