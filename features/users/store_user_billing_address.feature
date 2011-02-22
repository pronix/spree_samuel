# language: en

Feature: Store User Billing Address
  In order to store the user billing address,
  A User having an account
  Should be login into the site

  Scenario: viewing the store billing address page
    Given I am logged in
    When I am on store billing address page
    Then I see the page

  Scenario: with empty information for billing address
    Given I am logged in
    When I am on store billing address page
    And I fill in "First name" with ""
    And I fill in "Last Name" with ""
    And I fill in "Address 1" with ""
    And I fill in "Address 2" with ""
    And I fill in "City" with ""
    And I fill in "State" with ""
    And I fill in "Country" with ""
    And I fill in "Zip Code" with ""
    And I press "Save"
    Then billing address not saved
    And I am shown the store billing address page
    And I should see "You should enter the required Information!"

  Scenario: with required information for billing address
    Given I am logged in
    When I am on store billing address page
    And I fill in "First name" with "spree"
    And I fill in "Last Name" with "samuel"
    And I fill in "Address 1" with "address one"
    And I fill in "Address 2" with "address two"
    And I fill in "City" with "lahore"
    And I fill in "State" with "punjab"
    And I fill in "Country" with "pakistan"
    And I fill in "Zip Code" with "54000"
    And I press "Save"
    Then billing address saved
    And I should see "Your billing address successfully saved!"

