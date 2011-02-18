# language: en

Feature: Seller's sign out
  To protect my account from unauthorized access
  A signed in seller
  Should be able to sign out

  Background:
   Given I go to the home page
   And I am logged out
   And I have an admin account of "admin@spree.com/123456"

  @green
  Scenario: Log out
    Given I am signed up as "seller@spree.com/password" with roles "seller"
    When I sign in as "seller@spree.com/password"
    Then I should be logged in
    And I should be on the admin page
    And I should be viewing seller dashboard
    When I follow "Logout"
    Then I should be logged out
    And I should be on the root page
    When I go to the admin page
    Then I am shown the user login page
