Feature: View Invoices
  In order to view Invoices
  A Admin having an account
  Should be login into the Admin site

  Scenario: viewing the invoices page
    Given I am logged in
    When I am on invoices page
    Then I see the page

  Scenario: viewing invoices by date
    Given I am logged in
    When I am on invoices page
    And i enter the required date
    And i press the "Search"
    Then i see the invoices page
    And I see the invoices of entered date

  Scenario: viewing invoices by username
    Given I am logged in
    When I am on invoices page
    And i enter the username
    And i press the "Search"
    Then i see the invoices page
    And I see the invoices of entered username

  Scenario: viewing invoices by userid
    Given I am logged in
    When I am on invoices page
    And i enter the userid
    And i press the "Search"
    Then i see the invoices page
    And I see the invoices of entered userid

  Scenario: viewing invoices by email
    Given I am logged in
    When I am on invoices page
    And i enter the email
    And i press the "Search"
    Then i see the invoices page
    And I see the invoices of entered email
