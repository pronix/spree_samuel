Feature: Track Sales
  In order to track sales
  A Admin having an account
  Should be login into the Admin site

  Scenario: viewing the sales page
    Given I am logged in
    When I am on sales page
    Then I see the page

  Scenario: track sales by product
    Given I am logged in
    When I am on sales page
    And I enter the required product
    And I press the "Track"
    Then I see the sales page
    And I see the sales of entered product

  Scenario: track sales by category
    Given I am logged in
    When I am on sales page
    And I enter the required category
    And I press the "Track"
    Then I see the sales page
    And I see the sales of entered category

  Scenario: track sales by user
    Given I am logged in
    When I am on sales page
    And i enter the required user
    And i press the "Track"
    Then i see the sales page
    And I see the sales of entered user

  Scenario: track sales by payment method
    Given I am logged in
    When I am on sales page
    And i enter the required payment method
    And i press the "Track"
    Then i see the sales page
    And I see the sales of entered payment method

  Scenario: track sales by coupon code
    Given I am logged in
    When I am on sales page
    And i enter the required coupon code
    And i press the "Track"
    Then i see the sales page
    And I see the sales of entered coupon code

  Scenario: track sales by vendor
    Given I am logged in
    When I am on sales page
    And i enter the required vendor
    And i press the "Track"
    Then i see the sales page
    And I see the sales of entered vendor