Feature: View Current State
  In order to view current state
  A Admin having an account
  Should be login into the Admin site

  Scenario: viewing the Current State page
    Given I am logged in
    When I am on admin dashboard page
    Then I see current state of the application