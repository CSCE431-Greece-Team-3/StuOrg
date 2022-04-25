Feature: Sort by Product Organization
    As an app user
    So I can sort by products
    I want to use the sort by product organization feature 

Scenario: I choose rspec
    Given I am on the home page
    When I press the "MARKETPLACE" link
    Then I should be on the marketplace page
    When I select "rspec" from "org_id"
    Then I should see "MARKETPLACE"