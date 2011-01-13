Feature: Manage Coupon
  In order to manage coupons
  A User having an account
  Should be login into the API site

  Scenario: viewing the coupons list page
    Given I am logged in
    When I am on coupons list page
    Then I see the page

  Scenario: viewing the create coupon page
    Given I am logged in
    When I am on create coupon page
    Then I see the page

  Scenario: with empty information for coupon
    Given I am logged in
    When I am on create page
    And I leave the required information empty
    And I press "Save"
    Then coupon was not saved
    And I am shown the create coupon page
    And I should see "Coupon was not successfully saved!"

  Scenario: with required information for coupon
    Given I am logged in
    When I am on create page
    And I fill the required information
    And I press "Save"
    Then coupon is saved
    And I am shown the show coupon page
    And I should see "Coupon successfully saved!"

  Scenario: with required information for coupon
    Given I am logged in
    When I am on generate invoice page
    And I fill the required information
    And I press "Generate"
    Then invoice generated
    And I am shown the print invoice page
    And I should see "Invoice successfully generated!"

  Scenario: viewing the coupon show page
    Given I am logged in
    When I am on show coupon page
    Then I see the information of the coupon

  Scenario: viewing the edit coupon page
    Given I am logged in
    When I am on edit coupon page
    Then I see the page

  Scenario: with empty information for edit coupon
    Given I am logged in
    When I am on edit coupon page
    And I leave the required information empty
    And I press "Update"
    Then coupon was not updated
    And I am shown the edit coupon page
    And I should see "Coupon was not successfully updated!"

  Scenario: with required information for edit coupon
    Given I am logged in
    When I am on edit coupon page
    And I fill the required information
    And I press "Update"
    Then coupon updated
    And I am shown the show coupon page
    And I should see "Coupon successfully updated!"

  Scenario: delete coupon
    Given I am logged in
    When I am on coupons list page
    And I should see the "Delete" link
    And I press "Delete"
    Then I see the confirmation box
    And I press "Confirm"
    Then coupon was not updated
    Then coupon deleted
    And I am shown the coupons list page
    And I should see "Coupon was successfully deleted!"
