Feature: Sign Up as a Member
    As an organization member
    So I can sell products
    I want to create a personal account

Scenario: I sign up as a member  

    Given I am on the home page
    When I press the "SIGN UP" link
    When I press the "Member" link
    Then I should be on the member sign up page
    And I should see "I am trying to sign up as a ..."
    And I should see "Member"
    And I will sign up with "Anu" "Khatri", "anukhatri41@gmail.com" username, and "Howdy123" password
    Then I should be on the member profile page
    And I should see "Howdy"