Feature: Write post
As a user
I can write new post
  Scenario: Write new post
    Given I am on the homepage
    When I fill "My new post" as content
    And I select friend
    And I click "Send!" button
    Then I should see the post I just sended
