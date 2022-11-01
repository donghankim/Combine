Feature: Add New Tv-show
    Background:
      Given user has logged in

    Scenario: Add a Tv-show
      When I press "Add TV Show"
      And I fill tv-show details I want to add
      And I press "Create Tv show"
      Then I should see the tv-show card page
      When I press "Return"
      Then I should see the new tv-show on my tv-shows table