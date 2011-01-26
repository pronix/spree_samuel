Feature: View Credit Card Transactions
  In order to view transactions
  A Admin having an account
  Should be login into the Admin site

  Scenario: viewing the credit card transaction page
    Given I am logged in
    When I am on credit card transaction page
    Then I see the page

  Scenario: viewing credit card transaction by date
    Given I am logged in
    When I am on credit card transaction page
    And i enter the required date
    And i press the "Search"
    Then i see the credit card transaction page
    And I see the transactions of entered date

  Scenario: viewing credit card transaction by username
    Given I am logged in
    When I am on credit card transaction page
    And i enter the username
    And i press the "Search"
    Then i see the credit card transaction page
    And I see the transactions of entered username

  Scenario: viewing credit card transaction by user_id
    Given I am logged in
    When I am on credit card transaction page
    And i enter the user_id
    And i press the "Search"
    Then i see the credit card transaction page
    And I see the transactions of entered user_id

  Scenario: viewing credit card transaction by email
    Given I am logged in
    When I am on credit card transaction page
    And i enter the email
    And i press the "Search"
    Then i see the credit card transaction page
    And I see the transactions of entered email



  