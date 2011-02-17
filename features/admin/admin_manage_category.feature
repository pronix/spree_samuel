# language: en

@green
Feature: Manage Category
  In order to manage categories
  An Admin having an account
  Should be login into the Admin site

  Background:
    Given I am logged in as admin "admin@spree.com" with "password"
    And there is next tax categories:
      |name        | description                     | is_default |
      | category1  | this is category 1 description  | 1          |
      | category10 | this is category 10 description | 0          |
    And I am on the new admin tax category page

  Scenario: viewing the categories list page
    When I am on the admin tax categories page
    Then I should see "Listing Tax Categories"

  Scenario: viewing the create category page
    Then I should see "New Tax Category"

  Scenario: with empty information for category
    And I fill in "Name" with ""
    And I press "Create"
    Then I should see "New Tax Category"
    And I should see "Name can't be blank"

  Scenario: with dublicated information for category
    And I fill in "Name" with "category1"
    And I press "Create"
    Then I should see "New Tax Category"
    And I should see "Name has already been taken"

  Scenario: with required information for category
    And I fill in "Name" with "new_category"
    And I press "Create"
    Then I should be on the admin tax categories page
    And I should see "Successfully created!"

  Scenario: viewing the category show page
    When I am on the "category1" tax category page
    Then I should see "this is category 1 description"
    And I should see "category1"

  Scenario: viewing the edit category page
    When I am on the edit "category1" tax category page
    Then I should see "Editing Tax Category"

  Scenario: with empty information for edit category
    When I am on the edit "category1" tax category page
    And I fill in "Name" with ""
    And I press "Update"
    Then I should see "Editing Tax Category"
    And I should see "Name can't be blank"

  Scenario: with dublicate information for edit category
    When I am on the edit "category1" tax category page
    And I fill in "Name" with "category10"
    And I press "Update"
    Then I should see "Editing Tax Category"
    And I should see "Name has already been taken"

  Scenario: with required information for edit category
    When I am on the edit "category1" tax category page
    And I fill in "Name" with "edit_category"
    And I press "Update"
    Then I should be on the admin tax categories page
    And I should see "Successfully updated!"

  @javascript
  Scenario: delete category
    When I am on the admin tax categories page
    Then I should see the tax category Delete link for "category1"
    When I follow tax category Delete link for "category1"
    And I should see the deletion confirmation box
    And I confirm popup ok
    Then I should be on the admin tax categories page
    #Reload page
    When I am on the admin tax categories page
    And tax category "category1" should be deleted
