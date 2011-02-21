# language: en

Feature: Track Accounts
  In order to track accounts
  A Admin having an account
  Should be login into the Admin site

  Background:
    Given I am logged in as admin "admin@spree.com" with "password"

  Scenario: viewing the Accounts page
    When I am on admin track accounts page
    Then I see the page

  Scenario: track accounts payable for event producer
    When I am on accounts page
    And I enter the event producer
    And I press the "Track"
    Then I see the accounts page
    And I see the accounts payable for event producer

