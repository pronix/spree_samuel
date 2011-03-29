# language: en

@green
Feature: Manage Category(taxons)
  In order to view and add new categories
  A Seller having an account
  Should be login into the site

  Background:
    Given I have an admin account of "admin@spree.com/123456"
      And the following users exist:
        | email             | password  | roles  |
        | seller@spree.com  | password  | seller |
        | seller1@spree.com | password1 | seller |
      And the following taxonomies exist:
        | name    |
        | Tickets |
        | Drink   |
      And I sign in as "seller@spree.com/password"

  Scenario: viewing the categories list page
    When I go to the admin taxonomies page
    Then I should see in admin panel the following list of "taxonomies":
      | Name    |
      | Tickets |
      | Drink   |
    And I should not see the taxonomy Delete link for "Tickets"
    And I should not see the taxonomy Delete link for "Drink"

  Scenario: Adding a new category
    When I go to the admin taxonomies page
     And I follow "New Taxonomy"
     And I fill in "taxonomy_name" with "Event"
     And I press "Create"
    Then I should see "Successfully created!"
     And I should be on the admin edit "Event" taxonomy page

  Scenario: Adding an existing category
    When I go to the admin taxonomies page
     And I follow "New Taxonomy"
     And I fill in "taxonomy_name" with "Tickets"
     And I press "Create"
    Then I should see "has already been taken"

  @javascript
  Scenario: View nested categories
    When I am on the admin edit "Tickets" taxonomy page
    Then I should see "Tree"
     And I should see "Tickets" within "#taxonomy_tree"
     And I should not see "Update"

  @javascript
  Scenario: Adding a new nested categories
    When I am on the admin edit "Tickets" taxonomy page
    Then I should see "Tree"
     And I should see "Tickets" within "#taxonomy_tree"
    When I click right button on "Tickets" element tree
    Then I should view context menu for seller

