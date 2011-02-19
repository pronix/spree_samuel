Feature: Manage Inventory level
  In order to manage inventory levels
  Am Admin having an account
  Should be login into the Admin site

  Scenario: viewing the inventory levels list page
    Given I am logged in
    When I am on inventory levels list page
    Then I see the page

  Scenario: viewing the create inventory level page
    Given I am logged in
    When I am on create inventory level page
    Then I see the page

  Scenario: with empty information for inventory level
    Given I am logged in
    When I am on create page
    And I leave the required information empty
    And I press "Save"
    Then inventory level was not saved
    And I am shown the create inventory level page
    And I should see "Inventory level was not successfully saved!"

  Scenario: with required information for inventory level
    Given I am logged in
    When I am on create page
    And I fill the required information
    And I press "Save"
    Then inventory level is saved
    And I am shown the show inventory level page
    And I should see "Inventory level successfully saved!"

  Scenario: with required information for inventory level
    Given I am logged in
    When I am on generate invoice page
    And I fill the required information
    And I press "Generate"
    Then invoice generated
    And I am shown the print invoice page
    And I should see "Invoice successfully generated!"

  Scenario: viewing the inventory level show page
    Given I am logged in
    When I am on show inventory level page
    Then I see the information of the inventory level

  Scenario: viewing the edit inventory level page
    Given I am logged in
    When I am on edit inventory level page
    Then I see the page

  Scenario: with empty information for edit inventory level
    Given I am logged in
    When I am on edit inventory level page
    And I leave the required information empty
    And I press "Update"
    Then inventory level was not updated
    And I am shown the edit inventory level page
    And I should see "Inventory level was not successfully updated!"

  Scenario: with required information for edit inventory level
    Given I am logged in
    When I am on edit inventory level page
    And I fill the required information
    And I press "Update"
    Then inventory level updated
    And I am shown the show inventory level page
    And I should see "Inventory level successfully updated!"

  Scenario: delete inventory level
    Given I am logged in
    When I am on inventory levels list page
    And I should see the "Delete" link
    And I press "Delete"
    Then I see the confirmation box
    And I press "Confirm"
    Then inventory level was not updated
    Then inventory level deleted
    And I am shown the inventory levels list page
    And I should see "Inventory level was successfully deleted!"
