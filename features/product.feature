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

Scenario: I try to delete a listing with a title

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
    When I fill in "product[quantity]" with "10"
    When I fill in "product[price]" with "11.99"
    And I attach the file "features/test_images/water_bottle.jpg" to "product[image]"
    When I press the "Create Product" button
    Then I should be on the products page
    Then I should see "Water Bottle"
    Then I should see "Quantity: 10"
    Then I should see "Price: $11.99"
    When I press the "Delete Product" button
    Then I should see "Product was successfully destroyed."

Scenario: I try to edit a listing with a title

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
    When I fill in "product[quantity]" with "10"
    When I fill in "product[price]" with "11.99"
    And I attach the file "features/test_images/water_bottle.jpg" to "product[image]"
    When I press the "Create Product" button
    Then I should be on the products page
    Then I should see "Water Bottle"
    Then I should see "Quantity: 10"
    Then I should see "Price: $11.99"
    When I press the "Edit Product" button
    When I fill in "product[title]" with "White Water Bottle"
    Then I press the "Update Product" button
    Then I should see "White Water Bottle"
    Then I should see "Quantity: 10"
    Then I should see "Price: $11.99"