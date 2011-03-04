# language: en

Feature: User Buy products
  In order to buy products
  A User having an account
  Should be login into the site

  Background:
    Given I have an admin account of "admin@spree.com/123456"
      And load default data
      And the following users exist:
        | email          | password | roles |
        | user@spree.com | password | user  |
      And I sign in as "user@spree.com/password"
      And there is next products:
        | name      | price | generate_qr_code |
        | product1  |  1000 |                1 |
        | product10 |   150 |                0 |
      And I go to the home page

  Scenario: viewing products page
    Then I should see "Shop by Category"

  Scenario: empty cart
    Given I add a product with price: 1,000.00, name: "product1" to cart
    Then I should see "Shopping Cart"
    And I press "empty cart"
    Then cart should be empty

  @javascript
  Scenario: buy products
    Given I add a product with price: 1,000.00, name: "product1" to cart
    And I go to the home page
    And I add a product with price: 1,000.00, name: "product1" to cart
    Then I should see "Shopping Cart"
    And I follow "Checkout"
    Then I should see "Checkout"
    And I should see "Billing Address"
    And I should see "Shipping Address"
    And I press "save and continue"
    Then I should see "Payment Information"
    And I select "Check"
    And I press "save and continue"
    Then I should see "Confirm"
    Then I should see "Order summary"
    And I press "place order"
    Then I should see "Your order has been processed successfully"
    And I should see qr_code for product with price: 1,000.00, name: "product1"

