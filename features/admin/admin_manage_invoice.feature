Feature: Manage Invoice
  In order to manage invoices
  An Admin having an account
  Should be login into the Admin site

  Background:
    Given I have an admin account of "admin@spree.com/123456"
      And exist payment method Check
      And the following taxonomies exist:
        | name    |
        | Tickets |
        | Drink   |
      And the following products exist:
        | name        | price | taxon  |
        | Product1    | 10    | Drink  |
        | Product2    | 20    | Drink  |
      And the following orders exist:
        | number    | email             | state    | products   | payment_method  |
        | Order1    | seller@spree.com  | complete | Product1:1 | Check           |
        | Order2    | seller1@spree.com | cart     | Product2:1 | Check           |
      And I sign in as "admin@spree.com/123456"

  Scenario: viewing the invoices list page
    When I go to the admin orders page
    Then I should see in admin panel the following list of "orders":
      | Number |
      | Order2 |
      | Order1 |

  Scenario: viewing the create invoice page
    When I go to the admin orders page
     And I follow "New Order"
     Then I should see "Continue" within "form"

  Scenario: with empty information for invoice
    When I go to the admin orders page
     And I follow "New Order"
     And I leave the required information empty
     And I press "Continue"
    Then I should see "prohibited this record from being saved"
     And I should see "Line items can't be blank"

  @provided
  @javascript
  Scenario: with required information for invoice
    When I go to the admin orders page
     And I follow "New Order"
     And I fill in "Name" with "Product1"
     And I select "Product1" from "Name"
     And I follow "Add"
     And I press "Continue"
    Then I should see "Successfully created!"

  @wip
  @javascript
  Scenario: viewing the invoice show page
    When I go to the admin orders page
     And I follow "Order1"
     And show me the page

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
