# language: en

Feature: Track Sales
  In order to track sales
  A Admin having an account
  Should be login into the Admin site

  Background:
   Given I have an admin account of "admin@spree.com/123456"
     And load default data
     And exist payment method Check
     And the following users exist:
      | email               | password  | roles  |
      | seller@spree.com    | password  | seller |
      | seller1@spree.com   | password1 | seller |
      | customer@spree.com  | password  |        |
      | customer1@spree.com | password1 |        |
      | customer2@spree.com | password2 |        |
      And the following promotions exist:
        | name    | description | code  | seller            |
        | Coupon1 | Coupon 1    | CODE1 | seller@spree.com  |
        | Coupon2 | Coupon 2    | CODE2 | seller1@spree.com |
     And the following taxonomies exist:
      | name    |
      | Tickets |
      | Drink   |
     And the following products exist:
      | name    | sku | price | available_on        | created_at | taxon   | seller            | on_hand |
      | Ticket1 | TT1 |   230 | 2010-03-06 18:48:21 | 12/10/2010 | Tickets | seller@spree.com  |       2 |
      | Ticket2 | TT2 |   130 | 2010-04-06 8:48:21  | 12/10/2010 | Tickets | seller1@spree.com |      11 |
     And the following orders exist:
      | created_at  | number | user_email          | state    | products  | payment_method |
      | lambda{Time.now} | R56892 | customer1@spree.com | complete | Ticket1:1 | Check          |
      | lambda{Time.now} | R54192 | customer@spree.com  | complete | Ticket2:1 | Check          |
      | lambda{Time.now} | R54023 | customer1@spree.com | complete | Ticket1:1 | Check          |
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

  @green
  Scenario: track sales by product
    When I am on the admin reports page
     And I follow "Advanced Sales"
     And I follow "Ticket1"
    Then I should see the following product sales:
      | Date              | Units | Revenue |
      | February 27, 2011 |   2.0 | $460.00 |

  @green
  Scenario: track sales by category
    When I am on the admin reports page
     And I follow "Advanced Sales"
     And I follow "Tickets"
    Then I should see the following taxons sales:
      | Date              | Product | Units | Revenue |
      | February 27, 2011 | Ticket1 |   2.0 | $460.00 |
      | February 27, 2011 | Ticket2 |   1.0 | $130.00 |

  @green
  Scenario: track sales by payment method
    When I am on the admin reports page
     And I follow "Advanced Sales"
     And I follow "Check"
    Then I should see the following payment method sales:
      | Date              | Units | Revenue |
      | February 27, 2011 |     3 | $590.00 |

  @wip
  Scenario: track sales by coupon code
    When I am on the admin reports page
     And I follow "Advanced Sales"
     And I follow "Coupon1"
    Then I should see the following taxons sales:
      | Date              | Product | Units | Revenue |
      | February 27, 2011 | Ticket1 |   2.0 | $460.00 |
      | February 27, 2011 | Ticket2 |   1.0 | $130.00 |


