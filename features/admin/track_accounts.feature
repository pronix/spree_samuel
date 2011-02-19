Feature: Track Accounts
  In order to track accounts
  A Admin having an account
  Should be login into the Admin site

  Scenario: viewing the Accounts page
    Given I am logged in
    When I am on accounts page
    Then I see the page

  Scenario: track accounts payable for event producer
    Given I am logged in
    When I am on accounts page
    And I enter the event producer
    And I press the "Track"
    Then I see the accounts page
    And I see the accounts payable for event producer

