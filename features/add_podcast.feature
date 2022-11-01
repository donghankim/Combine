Feature: Add New Podcast
    Background:
      Given user has logged in

    Scenario: Add a Podcast
      When I press "Add Podcast"
      And I fill podcast details I want to add
      And I press "Create Podcast"
      Then I should see the podcast card page
      When I press "Return"
      Then I should see the new podcast on my podcasts table

    Scenario: Edit a Podcast
      When I add a podcast
      And I click on the new podcast
      And I press "Edit Podcast"
      And I fill podcast details I want to edit
      When I press "Update Podcast"
      Then I should see the edited podcast card page
      When I press "Return"
      Then I should see the edited podcast on my podcasts table

    Scenario: Delete a Podcast
      When I add a podcast
      And I click on the new podcast
      When I press "Remove"
      Then I should not see the podcast
