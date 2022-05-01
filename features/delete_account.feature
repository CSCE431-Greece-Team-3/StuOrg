Feature: Delete an Account
    As an organization / member
    So I can remove my data
    I want to delete my account

Scenario: I delete account as a member  

    Given I am on the home page
    When I press the "SIGN UP" link
    When I press the "Member" link
    Then I should be on the member sign up page
    And I should see "I am trying to sign up as a ..."
    And I should see "Member"
    And I will sign up with "Anu" "Khatri", "anukhatri41@gmail.com" username, and "Howdy123" password
    Then I should be on the member profile page
    And I should see "Anu"
    Then I press the "Edit Profile" link
    And I should see "Edit Existing Member Account"
    Then I press the "Delete Account" button
    Then I should be on the home page

Scenario: I delete account as a organization  

    Given I am on the home page
    When I press the "SIGN UP" link
    When I press the "Organization" link
    Then I should be on the organization sign up page
    And I should see "I am trying to sign up as an ..."
    When I will sign up with "Aggie Outdoors" organization name, "outdoors@gmail.com" username, and "Howdy123" password
    Then I should be on the profile page
    And I should see "Aggie Outdoors"
    When I press the "Account" link
    And I should see "Edit Existing Organization Account"
    Then I press the "Delete Account" button
    Then I should be on the home page