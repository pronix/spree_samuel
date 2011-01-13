Feature: Manage Product
  In order to manage products
  A User having an account
  Should be login into the API site

  Scenario: viewing the products list page
    Given I am logged in
    When I am on products list page
    Then I see the page

  Scenario: viewing the create product page
    Given I am logged in
    When I am on create product page
    Then I see the page

  Scenario: with empty information for product
    Given I am logged in
    When I am on create page
    And I leave the required information empty
    And I press "Save"
    Then product was not saved
    And I am shown the create product page
    And I should see "Product was not successfully saved!"

  Scenario: with required information for product
    Given I am logged in
    When I am on create page
    And I fill the required information
    And I press "Save"
    Then product is saved
    And I am shown the show product page
    And I should see "Product successfully saved!"

  Scenario: with required information for product
    Given I am logged in
    When I am on generate invoice page
    And I fill the required information
    And I press "Generate"
    Then invoice generated
    And I am shown the print invoice page
    And I should see "Invoice successfully generated!"

  Scenario: viewing the product show page
    Given I am logged in
    When I am on show product page
    Then I see the information of the product

  Scenario: viewing the edit product page
    Given I am logged in
    When I am on edit product page
    Then I see the page

  Scenario: with empty information for edit product
    Given I am logged in
    When I am on edit product page
    And I leave the required information empty
    And I press "Update"
    Then product was not updated
    And I am shown the edit product page
    And I should see "Product was not successfully updated!"

  Scenario: with required information for edit product
    Given I am logged in
    When I am on edit product page
    And I fill the required information
    And I press "Update"
    Then product updated
    And I am shown the show product page
    And I should see "Product successfully updated!"

  Scenario: delete product
    Given I am logged in
    When I am on products list page
    And I should see the "Delete" link
    And I press "Delete"
    Then I see the confirmation box
    And I press "Confirm"
    Then product was not updated
    Then product deleted
    And I am shown the products list page
    And I should see "Product was successfully deleted!"
