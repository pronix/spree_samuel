# language: en

Feature: Configure
  In order to configure authorize_net
  A Admin having an account
  Should be login into the Admin site

  Background:
   Given I have an admin account of "admin@spree.com/123456"
     And I sign in as "admin@spree.com/123456"
     And the allready exist batches with statistics and transactions

  @green
  Scenario: See current month batches
    When I am on the admin transactions page
    Then I should see this month transactions
    And I should not see previous month transactions

  @javascript
  Scenario: See previous month batches
    When I am on the admin transactions page
    And I select previous month
    And I follow "Show"
    Then I should see previous month transactions
    And I should not see this month transactions