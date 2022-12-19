Feature: Add New Friend
    Background:
      Given user has logged in
      Given another user exists
      Given I am on the friends page

    Scenario: Add a Friend
      When I search a friend
      And I press "Add Friend"
      Then I should see my new friend in my friends list
      And I press "Profile"
      Then I should see my friends information

    Scenario: Delete a Friend
      When I search a friend
      And I press "Add Friend"
      When I press "Remove"
      Then I should not see the friend

    Scenario: Add Self as Friend
      When I add myself as a friend
      Then I should see an error

    Scenario: Add Unknown User as Friend
      When I add a non-existant user
      Then I should see an error

    Scenario: Add Same Friend Twice
      When I search a friend
      And I press "Add Friend"
      When I search a friend
      Then I should see an error

    Scenario: Log Out
      When they have logged out
      And I am on the friends page
      Then I should see a request to log in