Feature: Track Charge back
  In order to track charge back
  A Admin having an account
  Should be login into the Admin site

  Scenario: viewing the charges page
    Given I am logged in
    When I am on charges page
    Then I see the page

  Scenario: track charge back by user
    Given I am logged in
    When I am on charges page
    And i enter the required user
    And i press the "Track"
    Then i see the charges page
    And I see the charge backs of entered user

  Scenario: track charge back by event
    Given I am logged in
    When I am on charges page
    And i enter the required event
    And i press the "Track"
    Then i see the charges page
    And I see the charge backs of entered event

  Scenario: track charge back by date
    Given I am logged in
    When I am on charges page
    And i enter the required date
    And i press the "Track"
    Then i see the charges page
    And I see the charge backs of entered date

  Scenario: track charge back by vendor
    Given I am logged in
    When I am on charges page
    And i enter the required vendor
    And i press the "Track"
    Then i see the charges page
    And I see the charge backs of entered vendor