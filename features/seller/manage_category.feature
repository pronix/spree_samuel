# language: en

Feature: Manage Category(taxons)
  In order to view and add new categories
  A Seller having an account
  Should be login into the site

  Scenario: viewing the categories list page
    Given I am logged in
    When I am on categories list page
    Then I see the page

  Scenario: viewing the create category page
    Given I am logged in
    When I am on create category page
    Then I see the page

  Scenario: with empty information for category
    Given I am logged in
    When I am on create page
    And I leave the required information empty
    And I press "Save"
    Then category was not saved
    And I am shown the create category page
    And I should see "Category was not successfully saved!"

  Scenario: with required information for category
    Given I am logged in
    When I am on create page
    And I fill the required information
    And I press "Save"
    Then category is saved
    And I am shown the show category page
    And I should see "Category successfully saved!"

  Scenario: viewing the category show page
    Given I am logged in
    When I am on show category page
    Then I see the information of the category

  Scenario: viewing the edit category page
    Given I am logged in
    When I am on edit category page
    Then I see the page

  Scenario: with empty information for edit category
    Given I am logged in
    When I am on edit category page
    And I leave the required information empty
    And I press "Update"
    Then category was not updated
    And I am shown the edit category page
    And I should see "Category was not successfully updated!"

  Scenario: with required information for edit category
    Given I am logged in
    When I am on edit category page
    And I fill the required information
    And I press "Update"
    Then category updated
    And I am shown the show category page
    And I should see "Category successfully updated!"

  Scenario: delete category
    Given I am logged in
    When I am on categories list page
    And I should see the "Delete" link
    And I press "Delete"
    Then I see the confirmation box
    And I press "Confirm"
    Then category was not updated
    Then category deleted
    And I am shown the categories list page
    And I should see "Category was successfully deleted!"
