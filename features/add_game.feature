Feature: Add New Game
    Background:
      Given user has logged in

    Scenario: Add a Game
      When I press "Add Game"
      And I fill game details I want to add
      And I press "Create Game"
      Then I should see the game card page
      When I press "Return"
      Then I should see the new game on my games table

    Scenario: Edit a Game
      When I add a game
      And I click on the new game
      And I press "Edit Game"
      And I fill game details I want to edit
      When I press "Update Game"
      Then I should see the edited game card page
      When I press "Return"
      Then I should see the edited game on my games table

    Scenario: Delete a Game
      When I add a game
      And I click on the new game
      When I press "Remove"
      Then I should not see the game
