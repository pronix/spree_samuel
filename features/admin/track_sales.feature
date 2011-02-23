# language: en

Feature: Track Sales
  In order to track sales
  A Admin having an account
  Should be login into the Admin site

  Background:
   Given I have an admin account of "admin@spree.com/123456"
     And the following users exist:
      | email               | password  | roles  |
      | seller@spree.com    | password  | seller |
      | seller1@spree.com   | password1 | seller |
      | customer@spree.com  | password  |        |
      | customer1@spree.com | password1 |        |
      | customer2@spree.com | password2 |        |
     And the following taxonomies exist:
      | name    |
      | Tickets |
      | Drink   |
     And the following products exist:
      | name    | sku | price | available_on        | created_at | taxon   | seller            | on_hand |
      | Ticket1 | TT1 |   230 | 2010-03-06 18:48:21 | 12/10/2010 | Tickets | seller@spree.com  |       2 |
      | Ticket2 | TT2 |   130 | 2010-04-06 8:48:21  | 12/10/2010 | Tickets | seller1@spree.com |      11 |
     And the following orders exist:
      | created_at  | number | user_email          | state    | products  |
      | lambda{Time.now} | R56892 | customer1@spree.com | complete | Ticket1:1 |
      | lambda{Time.now} | R54192 | customer@spree.com  | complete | Ticket2:1 |
      | lambda{Time.now} | R54023 | customer1@spree.com | complete | Ticket1:1 |
     And I sign in as "admin@spree.com/123456"

  @green
  Scenario: viewing the sales page
    When I am on the admin reports page
    Then I should see the following list of reports:
      | Name           | Description                |
      | Top Products   | Top Products               |
      | Sales Total    | Sales total for all orders |
      | Order Count    | Order Count                |
      | Top Customers  | Top Customers              |
      | Geo Revenue    | Geo Revenue                |
      | Geo Units      | Geo Units                  |
      | Units          | Units                      |
      | Profit         | Profit                     |
      | Geo Profit     | Geo Profit                 |
      | Revenue        | Revenue                    |
      | Advanced Sales | Advanced Sales             |

  @green
  Scenario: track sales by user
    When I am on the admin reports page
     And I follow "Advanced Sales"
     And I follow "customer1@spree.com"
    Then I should see the following user sales:
      | Order  | Units | Revenue |
      | R54023 |     1 | $230.00 |
      | R56892 |     1 | $230.00 |


  @green
  Scenario: track sales by vendor
    When I am on the admin reports page
     And I follow "Advanced Sales"
     And I follow "seller@spree.com"
    Then I should see the following user sales:
      | Order  | Units | Revenue |
      | R54023 |     1 | $230.00 |
      | R56892 |     1 | $230.00 |

  @wip
  Scenario: track sales by product
    When I am on the admin reports page
    And I enter the required product
    And I press the "Track"
    Then I see the sales page
    And I see the sales of entered product

  @wip
  Scenario: track sales by category
    Given I am logged in
    When I am on sales page
    And I enter the required category
    And I press the "Track"
    Then I see the sales page
    And I see the sales of entered category

  @wip
  Scenario: track sales by payment method
    Given I am logged in
    When I am on sales page
    And i enter the required payment method
    And i press the "Track"
    Then i see the sales page
    And I see the sales of entered payment method

  @wip
  Scenario: track sales by coupon code
    Given I am logged in
    When I am on sales page
    And i enter the required coupon code
    And i press the "Track"
    Then i see the sales page
    And I see the sales of entered coupon code

