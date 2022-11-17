Feature: Add New Friend
    Background:
      Given user has logged in
      Given another user exists
      Given I am on the friends page

    Scenario: Add a Friend
      When I add a friend
      Then I should see my friends information
      And I press "Return"
      Then I should see my new friend in my friends list

    Scenario: Delete a Friend
      When I add a friend
      And I press "Return"
      And I click on the new friend
      When I press "Remove"
      Then I should not see the friend

    Scenario: Add Self as Friend
      When I add myself as a friend
      Then I should see an error saying "You can't add yourself as a friend"

    Scenario: Add Unknown User as Friend
      When I add a non-existant user
      Then I should see an error saying "Please add an existing user as a friend"

    Scenario: Add Same Friend Twice
      When I add a friend
      And I press "Return"
      When I add a friend
      Then I should see an error saying "You already have this friend"
