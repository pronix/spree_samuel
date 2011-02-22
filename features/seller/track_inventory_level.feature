# language: en

@green
Feature: Track Inventory Levels
  In order to track inventory levels
  A Seller having an account
  Should be login into the site

  Background:
    Given I have an admin account of "admin@spree.com/123456"
      And the following users exist:
        | email             | password  | roles  |
        | seller@spree.com  | password  | seller |
        | seller1@spree.com | password1 | seller |
      And the following taxonomies exist:
        | name    |
        | Tickets |
        | Drink   |
      And the following products exist:
        | name    | sku | price | available_on        | created_at | taxon   | seller            | on_hand |
        | Ticket1 | TT1 |   230 | 2010-03-06 18:48:21 | 12/10/2010 | Tickets | seller@spree.com  |       2 |
        | Ticket2 | TT2 |   130 | 2010-04-06 8:48:21  | 12/10/2010 | Tickets | seller1@spree.com |      11 |
      And I sign in as "seller@spree.com/password"

  Scenario: viewing the inventory levels page
    When I go to the admin products page
     And I follow "Inventory"
    Then I should see in admin panel the following inventory levels:
      | Product | Sku | Variant | On hand |
      | Ticket1 | TT1 | master  |       2 |


  Scenario: update inventory levels
    When I go to the admin products page
     And I follow "Inventory"
     And I fill in "100" with "on_hand" for variant "Ticket1:TT1"
     And I press "Update Inventory"
    Then I should see "Successfully Updated."
     And I should see in admin panel the following inventory levels:
      | Product | Sku | Variant | On hand |
      | Ticket1 | TT1 | master  |     100 |



