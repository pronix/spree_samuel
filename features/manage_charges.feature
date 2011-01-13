Feature: Manage Charges
  In order to manage charges
  An Admin having an account
  Should be login into the Admin site

  Scenario: viewing the create credit card charges page
    Given I am logged in
    When I am on create credit card charges page
    Then I see the page

  Scenario: with empty information for credit card charges
    Given I am logged in
    When I am on create credit card charges page
    And I leave the required information empty
    And I press "Save"
    Then credit card charges was not saved
    And I am shown the create credit card charges page
    And I should see "credit card charges was not successfully saved!"

  Scenario: with invalid information for credit card charges
    Given I am logged in
    When I am on create credit card charges page
    And I filled the required information with invalid values
    And I press "Save"
    Then credit card charges was not saved
    And I am shown the create credit card charges page
    And I should see "credit card charges was not successfully saved!"

  Scenario: with valid information for credit card charges
    Given I am logged in
    When I am on create credit card charges page
    And I filled the required information with valid values
    And I press "Save"
    Then credit card charges was saved
    And I am shown the admin dashboard page
    And I should see "credit card charges was successfully saved!"

  Scenario: viewing the process reverse credit card charges page
    Given I am logged in
    When I am on process reverse credit card charges page
    Then I see the page

  Scenario: with empty information for process reverse credit card charges
    Given I am logged in
    When I am on process reverse credit card charges page
    And I leave the required information empty
    And I press "Process"
    Then credit card charges was not processed
    And I am shown the process reverse credit card charges page
    And I should see "credit card charges was not successfully reversed!"

  Scenario: with invalid information for process reverse credit card charges
    Given I am logged in
    When I am on process reverse credit card charges page
    And I filled the required information with invalid values
    And I press "Process"
    Then credit card charges was not reversed
    And I am shown the process reverse credit card charges page
    And I should see "credit card charges was not successfully reversed!"

  Scenario: with valid information for process reverse credit card charges
    Given I am logged in
    When I am on process reverse credit card charges page
    And I filled the required information with valid values
    And I press "Process"
    Then credit card charges was reversed
    And I am shown the admin dashboard page
    And I should see "credit card charges was successfully reversed!"

  Scenario: viewing the partial refunds page
    Given I am logged in
    When I am on partial refunds page
    Then I see the page

  Scenario: with empty information for partial refunds
    Given I am logged in
    When I am on partial refunds page
    And I leave the required information empty
    And I press "Done"
    Then partials was not refund
    And I am shown the partial refunds page
    And I should see "Charges was not successfully refund!"

  Scenario: with invalid information for partial refunds
    Given I am logged in
    When I am on partial refunds page
    And I filled the required information with invalid values
    And I press "Done"
    Then refunds was not refund
    And I am shown the partial refunds page
    And I should see "Charges was not successfully refund!"

  Scenario: with valid information for partial refunds
    Given I am logged in
    When I am on partial refunds page
    And I filled the required information with valid values
    And I press "Done"
    Then charges was refund
    And I am shown the admin dashboard page
    And I should see "Charges was successfully refund!"