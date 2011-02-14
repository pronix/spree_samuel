Feature: Admin Login
  In order to use the Admin site,
  An Admin having an account
  Should be able to login into the Admin site

  Background:
    Given I am not logged in
    When I go to the admin page
    Then I should be on the login page

   Scenario: with an empty login and password
    When I fill in "Email" with ""
    And I fill in "Password" with ""
    And I press "Log in"
    Then I should be on the new user session page
    And I should see "You need to sign in or sign up before continuing."

  Scenario: with a invalid login or password
    When I fill in "Email" with "user@spree.com"
    And I fill in "Password" with "test"
    And I press "Log in"
    Then I should be on the new user session page
    And I should see "Invalid email or password."

 Scenario: with a valid login and password
    Given I am logged in as admin "admin@spree.com" with "password"