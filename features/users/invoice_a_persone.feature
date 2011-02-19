Feature: Invoice a Person
  In order to invoice a person
  A User having an account
  Should be login into the API site

  Scenario: viewing the generate invoice page
    Given I am logged in
    When I am on generate invoice page
    Then I see the page

   Scenario: with empty information for invoice
    Given I am logged in
    When I am on generate invoice page
    And I leave the required information empty
    And I press "Generate"
    Then invoice was not generated
    And I am shown the generate invoice page
    And I should see "You should enter the required Information!"

  Scenario: with required information for invoice
    Given I am logged in
    When I am on generate invoice page
    And I fill the required information
    And I press "Generate"
    Then invoice generated
    And I am shown the print invoice page
    And I should see "Invoice successfully generated!"

 Scenario: print the generated invoice
    Given I am logged in
    When I am on print invoice page
    And I am shown the generated invoice information on page
    And I press "Print"
    Then invoice printed
    And I am shown the print invoice page
    And I should see "Invoice successfully printed!"
