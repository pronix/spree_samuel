# language: en

@green
Feature: Permissions Product
  Each seller has access only to their products

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

  Scenario: Access to edit goods of other sellers must be closed
    When I am on the edit "Ticket2" product page
    Then I should see "Authorization Failure"
