Feature: Add New Game
    Background:
      Given user has logged in

    Scenario: Add a Game
      When I press "Add Game"
      And I fill Game details I want to add
      And I press "Create Game"
      Then I should see the Game card page
      When I press "Return"
      Then I should see the the new Game on my Game table

