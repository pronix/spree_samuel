# language: en

@green
Feature: Manage Product
  In order to manage products
  A Seller having an account
  Should be login into the site
  Background:
    Given I have an admin account of "admin@spree.com/123456"
      And the following users exist:
        | email             | password  | roles  |
        | seller@spree.com  | password  | seller |
        | seller1@spree.com | password1 | seller |
      And the following categories exist:
        |Tickets|
      And the following products exist:
        | name    | sku | price | available_on        | created_at | taxon   | seller            |
        | Ticket1 | TT1 |   230 | 2010-03-06 18:48:21 | 12/10/2010 | Tickets | seller@spree.com  |
        | Ticket2 | TT2 |   130 | 2010-04-06 8:48:21  | 12/10/2010 | Tickets | seller1@spree.com |
      And I sign in as "seller@spree.com/password"

  Scenario: The seller can see a list of their products and not seeing other seller's goods
    When I go to the admin products page
    Then I should see in admin panel the following list of products:
      | Name    | Sku | Master Price |
      | Ticket1 | TT1 |          230 |
     And I should not see in admin panel the following list of products:
      | Name    | Sku | Master Price |
      | Ticket2 | TT2 |          130 |



  Scenario: viewing the create product page
    When I go to the admin products page
     And I follow "New Product"
    Then I should see "Create" within "form"

  Scenario: with empty information for product
    When I go to the admin products page
     And I follow "New Product"
     And I fill in "Name" with ""
     And I fill in "Master Price" with ""
     And I press "Create"
     And I should see "prohibited this record from being saved"
     And I should see "Name can't be blank"
     And I should see "Price can't be blank"

  Scenario: with required information for product
    When I go to the admin products page
     And I follow "New Product"
     And I am on the new admin product page
     And I fill in "Name" with "new_product"
     And I fill in "Master Price" with "1500"
     And I press "Create"
    Then I should be on the edit "new_product" product page
     And I should see "Successfully created!"

  Scenario: viewing the edit product page
    When I am on the edit "Ticket1" product page
    Then I should see "Editing Product"

  Scenario: with empty information for edit product
    When I am on the edit "Ticket1" product page
     And I fill in "Name" with ""
     And I fill in "Master Price" with ""
     And I press "Update"
     And I should see "can't be blank"

  Scenario: with required information for edit product
    When I am on the edit "Ticket1" product page
     And I fill in "Name" with "new_product"
     And I fill in "Master Price" with "1500"
     And I fill in "Permalink" with "product1"
     And I press "Update"
     And I should see "Successfully updated!"

  @javascript
  Scenario: delete product
    When I am on the admin products page
    Then I should see the product Delete link for "Ticket1"
    When I follow product Delete link for "Ticket1"
     And I should see the deletion confirmation box
     And I confirm popup ok
    Then I should be on the admin products page
     And the goods "Ticket1" must be removed
