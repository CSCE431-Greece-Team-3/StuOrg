Feature: Sort by Product Tags
    As an app user
    So I can sort by products
    I want to use the sort by product tag feature 

Scenario: I choose Clothes
    Given I am on the home page
    When I press the "MARKETPLACE" link
    Then I should be on the marketplace page
    When I select "Clothes" from "tag_id"
    Then I should see "MARKETPLACE"