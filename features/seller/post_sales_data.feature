Feature: Post Sales Data
  In order to post sales data on quickbook
  A User having an account
  Should be login into the API site

  Scenario: viewing sales data page
    Given I am logged in
    When I am on sales data page
    Then I see the page

  Scenario: post sales data
    Given I am logged in
    When I am on sales data page
    And I should see the "Post" link
    And I press "Post"
    Then I see the confirmation box
    And I press "Confirm"
    Then sales data was posted
    And I am shown the sales data page
    And I should see "Sales Data was successfully posted!"
