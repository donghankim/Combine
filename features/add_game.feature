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