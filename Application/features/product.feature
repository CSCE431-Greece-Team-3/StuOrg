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
    Then I should be on the profile page
    And I should see "You are Logged In, Aggie Wranglers"
    When I press the "Add Product" button
    Then I should see "Create New Product"
    When I fill in "product_title" with "Water Bottle"
    And I attach the file "features/test_images/water_bottle.jpg" to "product_image"
    When I press the "Create Product" button
    Then I should see "Title: Water Bottle"

Scenario: I try to create a listing with no image

    Given I am on the home page
    When I press the "LOG IN" link
    Then I should be on the login page
    And I should see "Log In"
    Then I log in with "wranglers@gmail.com" username and "12345678" password
    Then I should be on the profile page
    And I should see "You are Logged In, Aggie Wranglers"
    When I press the "Add Product" button
    Then I should see "Create New Product"
    When I fill in "product_title" with "Water Bottle"
    When I press the "Create Product" button
    Then I should see "Image can't be blank"

Scenario: I try to create a listing with no title

    Given I am on the home page
    When I press the "LOG IN" link
    Then I should be on the login page
    And I should see "Log In"
    Then I log in with "wranglers@gmail.com" username and "12345678" password
    Then I should be on the profile page
    And I should see "You are Logged In, Aggie Wranglers"
    When I press the "Add Product" button
    Then I should see "Create New Product"
    And I attach the file "features/test_images/water_bottle.jpg" to "product_image"
    When I press the "Create Product" button
    Then I should see "Title can't be blank"