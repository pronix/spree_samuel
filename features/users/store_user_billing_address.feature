# language: en

@green
Feature: Store User Billing and Shipping Address
  In order to store the user billing and shipping address,
  A User having an account
  Should be login into the site

  Background:
    Given I have an admin account of "admin@spree.com/123456"
      And load default data
      And the following users exist:
        | email          | password | roles |
        | user@spree.com | password | user  |
      And I sign in as "user@spree.com/password"

  Scenario Outline: viewing the store Billing/Shipping address page
    When I am on the account page
    Then I follow "<title_link_resource>"
    Then I should be on the edit <resource> addresses page
  Examples:
      | resource | title_link_resource |
      | billing  | Billing Address     |
      | shipping | Shipping Address    |


  Scenario Outline: with empty information for Billing/Shipping address
    When I am on the account page
    Then I follow "<title_link_resource>"
    Then I should be on the edit <resource> addresses page
     And I fill in "First Name" with ""
     And I fill in "Last Name" with ""
     And I fill in "Street Address" with ""
     And I fill in "Street Address (cont'd)" with ""
     And I fill in "City" with ""
     And I fill in "address_state_name" with ""
     And I select "" from "Country"
     And I fill in "Zip" with ""
     And I press "Update"
    Then I should see error messages
  Examples:
      | resource | title_link_resource |
      | billing  | Billing Address     |
      | shipping | Shipping Address    |

  @javascript
  Scenario Outline: with required information for Billing/Shipping address
    When I am on the account page
    Then I follow "<title_link_resource>"
    Then I should be on the edit <resource> addresses page
    And I fill in "First Name" with "Paxton"
    And I fill in "Last Name" with "Balistreri"
    And I fill in "Street Address" with "E 23rd Street"
    And I fill in "Street Address (cont'd)" with ""
    And I fill in "City" with "New York"
    And I select "United States" from "Country"
    And I select "New York" from "address_state_id"
    And I fill in "Zip" with "10010"
    And I fill in "Phone" with "6959750380"
    And I press "Update"
    Then I should see "Successfully Updated."
    And I should see "Paxton"
    And I should see "Balistreri"
    And I should see "E 23rd Street"
    And I should see "New York"
    And I should see "Country"
    And I should see "New York"
    And I should see "10010"
    And I should see "6959750380"
  Examples:
      | resource | title_link_resource |
      | billing  | Billing Address     |
      | shipping | Shipping Address    |
