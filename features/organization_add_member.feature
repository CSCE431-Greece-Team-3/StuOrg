Feature: Add a member
    As an organization leader
    So I can track member activity
    I want to add members to my organization

Scenario: I want to add members to my organization

    Given I am on the home page
    When I press the "SIGN UP" link
    When I press the "Organization" link
    Then I should be on the organization sign up page
    And I should see "I am trying to sign up as an ..."
    When I will sign up with "Aggie Outdoors" organization name, "outdoors@gmail.com" username, and "Howdy123" password
    Then I should be on the profile page
    And I should see "Aggie Outdoors"
    When I press the "Add Members" link
    Then I should see "Add Member"
    When I fill in "add_members_username" with "derik@gmail.com"
    And I press the "Add Member" button
    Then I should see "User does not exist."
