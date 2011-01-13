Feature: Admin Login
  In order to use the Admin site,
  An Admin having an account
  Should be able to login into the Admin site

  Scenario: viewing the admin login page
    Given I am not logged in
    When I am on admin login page
    Then I see the page

   Scenario: with an empty login and password
    Given I am not logged in
    When I am on admin login page
    And I fill in "Login" with ""
    And I fill in "Password" with ""
    And I press "Log in"
    Then I am not logged in
    And I am shown the admin login page
    And I should see "Invalid Login name or password!"

  Scenario: with a invalid login or password
    Given I am not logged in
    When I am on admin login page
    And I fill in "Login" with "user@spree.com"
    And I fill in "Password" with "test"
    And I press "Log in"
    Then I am not logged in
    And I am shown the admin login page
    And I should see "Invalid Login name or password!"

 Scenario: with a valid login and password
    Given I am not logged in
    And I have an admin account
    When I am on admin login page
    And I fill in "Login" with "admin@spree.com"
    And I fill in "Password" with "password"
    And I press "Log in"
    Then I am logged in
    And I should be viewing admin dashboard
    And I should see "Successfully Logged In"
