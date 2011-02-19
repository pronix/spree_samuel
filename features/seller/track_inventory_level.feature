# language: en

Feature: Track Inventory Levels
  In order to track inventory levels
  A Seller having an account
  Should be login into the site

  Scenario: viewing the inventory levels page
    Given I am logged in
    When I am on inventory levels page
    Then I see the page

  Scenario: track inventory levels
    Given I am logged in
    When I am on inventory levels page
    And I enter the inventory level
    And I press the "Track"
    Then I see the inventory levels page
    And I see the information for entered inventory level

