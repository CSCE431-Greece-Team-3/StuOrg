Feature: Add a product
    As an organization leader
    So I can sell my products
    I want to set the product price

Scenario: I want to track the product quantity

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
    Then I should see "Water Bottle"
    Then I should see "Quantity: 10"
    Then I should see "Price: $11.99"