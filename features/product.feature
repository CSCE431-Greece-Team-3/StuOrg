Feature: Add a product
    As an organization leader
    So I can sell products
    I want to create a listing

Scenario: I create a listing  

    Given I am on the home page
    When I press the "SIGN UP" link
    When I press the "Organization" link
    Then I should be on the organization sign up page
    And I should see "I am trying to sign up as an ..."
    When I will sign up with "Aggie Outdoors" organization name, "outdoors@gmail.com" username, and "Howdy123" password
    Then I should be on the profile page
    And I should see "Aggie Outdoors"
    When I press the "Products" link
    Then I should see "Add New Product"
    When I press the "+" link
    Then I should see "Create New Product"
    When I fill in "product[title]" with "Water Bottle"
    And I attach the file "features/test_images/water_bottle.jpg" to "product[image]"
    When I press the "Create Product" button
    Then I should see "Water Bottle"

Scenario: I try to create a listing with no image

    Given I am on the home page
    When I press the "SIGN UP" link
    When I press the "Organization" link
    Then I should be on the organization sign up page
    And I should see "I am trying to sign up as an ..."
    When I will sign up with "Aggie Outdoors" organization name, "outdoors@gmail.com" username, and "Howdy123" password
    Then I should be on the profile page
    And I should see "Aggie Outdoors"
    When I press the "Products" link
    Then I should see "Add New Product"
    When I press the "+" link
    Then I should see "Create New Product"
    When I fill in "product[title]" with "Water Bottle"
    When I press the "Create Product" button
    Then I should see "Image can't be blank"

Scenario: I try to create a listing with no title

    Given I am on the home page
    When I press the "SIGN UP" link
    When I press the "Organization" link
    Then I should be on the organization sign up page
    And I should see "I am trying to sign up as an ..."
    When I will sign up with "Aggie Outdoors" organization name, "outdoors@gmail.com" username, and "Howdy123" password
    Then I should be on the profile page
    And I should see "Aggie Outdoors"
    When I press the "Products" link
    Then I should see "Add New Product"
    When I press the "+" link
    Then I should see "Create New Product"
    And I attach the file "features/test_images/water_bottle.jpg" to "product[image]"
    When I press the "Create Product" button
    Then I should see "Title can't be blank"