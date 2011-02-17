# language: en

Feature: User Login
  In order to use the API site,
  A User having an account
  Should be able to login into the API site

  @javascript @green
  Scenario: viewing the user login page
    Given I am logged out
    When I am on the login page
    Then I should see login form

  @javascript @green
  Scenario: with an empty username and password
    Given I am logged out
    When I am on the login page
    And I fill in "Email" with ""
    And I fill in "Password" with ""
    And I press "Log in"
    Then I should be logged out
    And I should see "You need to sign in or sign up before continuing."

  @javascript
  Scenario: with a invalid username or password
    Given I am logged out
    When I am on the login page
    And I fill in "Email" with "user@spree.com"
    And I fill in "Password" with "test"
    And I press "Log in"
    Then I should be logged out
    And I am shown the user login page
    And I should see "Invalid email or password."

  @wip
  Scenario: with a valid username and password
    Given I am not logged in
    And I am signed up as "user@spree.com/password"
    When I am on the login page
    And I fill in "Email" with "user@spree.com"
    And I fill in "Password" with "password"
    And I press "Log in"
    Then I should be logged in
    And I should be viewing user dashboard
