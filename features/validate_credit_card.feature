Feature: Validate Credit Card
  In order to validate the credit card,
  A User having an account
  Should be login into the API site

  Scenario: viewing credit card information page
    Given I am logged in
    When I am on credit card information page
    Then I see the page

  Scenario: with empty credit card information
    Given I am logged in
    When I am on credit card information page
    And I leave the required information empty
    And I press "Confirm"
    Then credit card information was not validated
    And I am shown the credit card information page
    And I should see "Credit Card was not validated!"

  Scenario: with invalid credit card information
    Given I am logged in
    When I am on credit card information page
    And I fill the required information with invalid data
    And I press "Confirm"
    Then credit card information was not validated
    And I am shown the credit card information page
    And I should see "Credit Card was not validated!"

  Scenario: with valid credit card information
    Given I am logged in
    When I am on credit card information page
    And I fill the required information with valid data
    And I press "Confirm"
    Then credit card information was validated
    And I am shown the user dashboard page
    And I should see "Credit Card was successfully validated!"