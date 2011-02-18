# language: en

@green
Feature: Seller's sign in
  In order to use the service
  A Seller having an account
  Should be able to login into the site

  Background:
   Given I go to the home page
   And I am logged out
   And I have an admin account of "admin@spree.com/123456"


  Scenario: with an empty username and password
    When I am on the login page
    And I fill in "Email" with ""
    And I fill in "Password" with ""
    And I press "Log in"
    Then I should be logged out
    And I should see "You need to sign in or sign up before continuing."

  Scenario: with a invalid username or password
    When I sign in as "seller@spree.com/password"
    Then I should be logged out
    And I am shown the user login page
    And I should see "Invalid email or password."

  Scenario: with a valid username and password
    Given I am signed up as "seller@spree.com/password" with roles "seller"
    When I sign in as "seller@spree.com/password"
    Then I should be logged in
    And I should be on the admin page
    And I should be viewing seller dashboard

