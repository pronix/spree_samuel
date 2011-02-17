Feature: Manage Invoice
  In order to manage invoices
  A User having an account
  Should be login into the API site

  Scenario: viewing the invoices list page
    Given I am logged in
    When I am on invoices list page
    Then I see the page

  Scenario: viewing the create invoice page
    Given I am logged in
    When I am on create invoice page
    Then I see the page

  Scenario: with empty information for invoice
    Given I am logged in
    When I am on create page
    And I leave the required information empty
    And I press "Save"
    Then invoice was not saved
    And I am shown the create invoice page
    And I should see "Invoice was not successfully saved!"

  Scenario: with required information for invoice
    Given I am logged in
    When I am on create page
    And I fill the required information
    And I press "Save"
    Then invoice is saved
    And I am shown the show invoice page
    And I should see "Invoice successfully saved!"

  Scenario: viewing the invoice show page
    Given I am logged in
    When I am on show invoice page
    Then I see the information of the invoice

  Scenario: viewing the edit invoice page
    Given I am logged in
    When I am on edit invoice page
    Then I see the page

  Scenario: with empty information for edit invoice
    Given I am logged in
    When I am on edit invoice page
    And I leave the required information empty
    And I press "Update"
    Then invoice was not updated
    And I am shown the edit invoice page
    And I should see "Invoice was not successfully updated!"

  Scenario: with required information for edit invoice
    Given I am logged in
    When I am on edit invoice page
    And I fill the required information
    And I press "Update"
    Then invoice updated
    And I am shown the show invoice page
    And I should see "Invoice successfully updated!"

  Scenario: delete invoice
    Given I am logged in
    When I am on invoices list page
    And I should see the "Delete" link
    And I press "Delete"
    Then I see the confirmation box
    And I press "Confirm"
    Then invoice was not updated
    Then invoice deleted
    And I am shown the invoices list page
    And I should see "Invoice was successfully deleted!"
