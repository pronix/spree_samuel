# language: en

@green
Feature: Manage Product
  In order to manage products
  An Admin having an account
  Should be login into the Admin site

  Background:
    Given I am logged in as admin "admin@spree.com" with "password"
    And there is next products:
      |name       | price        |
      | product1  | 1000         |
      | product10 | 150          |
    And I am on the new admin product page

  Scenario: viewing the products list page
    When I am on the admin products page
    Then I should see "Listing Products"

  Scenario: viewing the create product page
    Then I should see "Create" within "form"

  Scenario: with empty information for product
    And I fill in "Name" with ""
    And I fill in "Master Price" with ""
    And I press "Create"
    And I should see "prohibited this record from being saved"
    And I should see "Name can't be blank"
    And I should see "Price can't be blank"

  Scenario: with required information for product
    And I fill in "Name" with "new_product"
    And I fill in "Master Price" with "1500"
    And I press "Create"
    Then I should be on the edit "new_product" product page
    And I should see "Successfully created!"

  Scenario: viewing the edit product page
    When I am on the edit "product1" product page
    Then I should see "Editing Product"

  Scenario: with empty information for edit product
    When I am on the edit "product1" product page
    And I fill in "Name" with ""
    And I fill in "Master Price" with ""
    And I press "Update"
    And I should see "can't be blank"

  Scenario: with required information for edit product
    When I am on the edit "product1" product page
    And I fill in "Name" with "new_product"
    And I fill in "Master Price" with "1500"
    And I fill in "Permalink" with "product1"
    And I press "Update"
    And I should see "Successfully updated!"

  @javascript
  Scenario: delete product
    When I am on the admin products page
    Then I should see the product Delete link for "product1"
    When I follow product Delete link for "product1"
    # And show me the page
    And I should see the deletion confirmation box
    And I confirm popup ok
    Then I should be on the admin products page
    And the goods "product1" must be removed
