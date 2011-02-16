Feature: User Login
  In order to use the API site,
  A User having an account
  Should be able to login into the API site

  Scenario: viewing the user login page
    Given I am not logged in
    When I am on the login page
    Then I see the page

   Scenario: with an empty username and password
    Given I am not logged in
    When I am on the login page
    And I fill in "Email" with ""
    And I fill in "Password" with ""
    And I press "Log in"
    Then I am not logged in
    And I am shown the user login page
    And I should see "Invalid Login name or password!"

  Scenario: with a invalid username or password
    Given I am not logged in
    When I am on the login page
    And I fill in "Email" with "user@spree.com"
    And I fill in "Password" with "test"
    And I press "Log in"
    Then I am not logged in
    And I am shown the user login page
    And I should see "Invalid Login name or password!"

 Scenario: with a valid username and password
    Given I am not logged in
    And I have a user account
    When I am on the login page
    And I fill in "Email" with "user@spree.com"
    And I fill in "Password" with "password"
    And I press "Log in"
    Then I am logged in
    And I should be viewing user dashboard
