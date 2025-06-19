Feature: User Registration

  Scenario: Successful registration
    Given I am on the registration page
    When I fill in the registration form with the following details:
      | Field | Value |
      | Name | Jane  Doe |
      | Email | jane@example.com |
      | Password | 123456 |
    And I submit the registration form
    Then I should see a confirmation message saying "Registration successful!"
    And I should be redirected to the welcome page
