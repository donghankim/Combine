Feature: Add New Tv-show
    Background:
      Given user has logged in

    Scenario: Add a TV-show
      When I press "Add TV Show"
      And I fill tv-show details I want to add
      And I press "Create Tv show"
      Then I should see the tv-show card page
      When I press "Return"
      Then I should see the new tv-show on my tv-shows table

    Scenario: Edit a TV-show
      When I add a tv-show
      And I click on the new tv-show
      And I press "Edit Show"
      And I fill tv-show details I want to edit
      When I press "Update Tv show"
      Then I should see the edited tv-show card page
      When I press "Return"
      Then I should see the edited tv-show on my tv-shows table

    Scenario: Delete a TV-show
      When I add a tv-show
      And I click on the new tv-show
      When I press "Destroy"
      Then I should not see the tv-show