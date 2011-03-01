# language: en

@green
Feature: Track Accounts
  In order to track accounts
  A Admin having an account
  Should be login into the Admin site

  Background:
    Given I am logged in as admin "admin@spree.com" with "password"
      And the following users exist:
        | email               | password   | roles  |
        | seller@spree.com    | password   | seller |
        | customer@spree.com  | password1  |        |
        | customer1@spree.com | password11 |        |
      And the following taxonomies exist:
        | name    |
        | Tickets |
        | Drink   |
      And the following products exist:
        | name    | sku | price | available_on        | created_at | taxon   | seller           | on_hand |
        | Ticket1 | TT1 |   230 | 2010-03-06 18:48:21 | 12/10/2010 | Tickets | seller@spree.com |       2 |
      And the following orders exist:
        | created_at | number | user_email          | state    | total |
        | 06/11/2010 | R56892 | customer1@spree.com | complete | 100   |
        | 03/25/2010 | R54192 | customer@spree.com  | complete | 120   |
        | 02/17/2010 | R54023 | customer1@spree.com | complete | 98    |


  @javascript
  Scenario: viewing the Accounts page
    When I go to the admin track accounts page
    Then I should see the following list of users in track accounts:
      | user                | head                      | link       |
      | customer1@spree.com | User: customer1@spree.com | Show Track |
      | customer@spree.com  | User: customer@spree.com  | Show Track |
    When async I click "Show Track" within track accounts for "customer1@spree.com"
    Then I should see the following list of orders for "customer1@spree.com":
      | number | total   | payment state       |
      | R54023 | $98.00  | Balance Due $98.00  |
      | R56892 | $100.00 | Balance Due $100.00 |




