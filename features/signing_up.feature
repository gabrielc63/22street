Feature: Signing up

  Scenario: Unsuccessful signup
    Given I am on the signup page
    When I submit invalid signup information
    Then I should see an error message

  Scenario: Successful signup
    Given I visit the signup page
    When I submit valid signup information
    Then I should see my profile page
    And I should see a success message
