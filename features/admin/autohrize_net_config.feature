# language: en

Feature: Configure
  In order to configure authorize_net
  A Admin having an account
  Should be login into the Admin site

  Background:
   Given I have an admin account of "admin@spree.com/123456"
     And I sign in as "admin@spree.com/123456"

  @green @javascript
  Scenario: edit settings
    When I am on the edit admin general settings page
    Then I should see "Authorize Net api login"
    And I should see "Authorize Net api key"
    And I should see "Authorize Net gateway"
    When I fill in "preferences[authorize_net_api_login]" with "api_login"
    And I follow "Edit"
    And I fill in "preferences[authorize_net_api_key]" with "api_secret_key"
    And I fill in "preferences[authorize_net_api_gateway]" with "api_gateway"
    And I press "Update"
    Then I should be on the admin general settings page
    And I should see "Authorize Net api login:"
    And I should see "api_login"
    And I should see "Authorize Net api key:"
    And I should not see "api_secret_key"
    And I should see "XXXXXXXXXXXX_key"
    And I should see "Authorize Net gateway"
    And I should see "api_gateway"
    When I am on the edit admin general settings page
    And I should not see "api_secret_key"