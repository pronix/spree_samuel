# language: en

@green
Feature: Manage Coupon
  In order to manage coupons
  A Seller having an account
  Should be login into the site

  Background:
    Given I have an admin account of "admin@spree.com/123456"
      And the following users exist:
        | email             | password  | roles  |
        | seller@spree.com  | password  | seller |
        | seller1@spree.com | password1 | seller |
      And the following promotions exist:
        | name    | description | code  | seller            |
        | Coupon1 | Coupon 1    | CODE1 | seller@spree.com  |
        | Coupon2 | Coupon 2    | CODE2 | seller1@spree.com |
      And I sign in as "seller@spree.com/password"


  Scenario: viewing the coupons list page
    When I go to the admin promotions page
    Then I should see in admin panel the following list of promotions:
      | Name    | Description | Code  |
      | Coupon1 | Coupon 1    | CODE1 |
     And I should not see in admin panel the following list of promotions:
      | Description | Code  |
      | Coupon 2    | CODE2 |


  Scenario: viewing the create coupon page
    When I go to the admin promotions page
     And I follow "New Promotion"
    Then I should see "Create" within "form"


  Scenario: with empty information for coupon
    When I go to the admin promotions page
     And I follow "New Promotion"
     And I fill in "Name" with ""
     And I fill in "Code" with ""
     And I press "Create"
    Then I should see "prohibited this record from being saved"
     And I should see "Name can't be blank"
     And I should see "Code can't be blank"
     And I should be on the admin promotions page


  Scenario: with required information for coupon
    When I go to the admin promotions page
     And I follow "New Promotion"
     And I fill in "Name" with "Coupon3"
     And I fill in "Code" with "CP3"
     And I fill in "Description" with "Coupon 3"
     And I press "Create"
    Then I should see "Successfully created!"
     And I should be on the admin edit "Coupon3" promotion page
    When I go to the admin promotions page
    Then I should see in admin panel the following list of promotions:
      | Name    | Description | Code  |
      | Coupon1 | Coupon 1    | CODE1 |
      | Coupon3 | Coupon 3    | CP3   |


  Scenario: with empty information for edit coupon
    When I am on the admin edit "Coupon1" promotion page
     And I fill in "Name" with ""
     And I fill in "Code" with ""
     And I press "Update"
    Then I should see "prohibited this record from being saved"
     And I should see "Name can't be blank"
     And I should see "Code can't be blank"


  Scenario: with required information for edit coupon
    When I am on the admin edit "Coupon1" promotion page
     And I fill in "Name" with "Coupon11"
     And I fill in "Code" with "CODE11"
     And I press "Update"
    Then I should see "Successfully updated!"

  @javascript
  Scenario: delete coupon
    When I go to the admin promotions page
    Then I should see the promotion Delete link for "Coupon1"
    When I follow promotion Delete link for "Coupon1"
     And I confirm popup ok
    Then I should be on the admin promotions page
     And promotion "Coupon1" should be deleted
