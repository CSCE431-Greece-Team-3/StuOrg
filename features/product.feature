Feature: Add a product
    As an organization leader
    So I can sell products
    I want to create a listing

Scenario: I create a listing  

    Given I am on the home page
    When I press the "LOG IN" link
    Then I should be on the login page
    And I should see "Log In"
    Then I log in with "wranglers@gmail.com" username and "12345678" password

Scenario: I try to create a listing with no image

    Given I am on the home page
    When I press the "LOG IN" link
    Then I should be on the login page
    And I should see "Log In"
    Then I log in with "wranglers@gmail.com" username and "12345678" password

Scenario: I try to create a listing with no title

    Given I am on the home page
    When I press the "LOG IN" link
    Then I should be on the login page
    And I should see "Log In"
    Then I log in with "wranglers@gmail.com" username and "12345678" password