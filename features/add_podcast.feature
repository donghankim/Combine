Feature: Add New Podcast
    Background:
      Given user has logged in

    Scenario: Add a Podcast
      When I press "Add Podcast"
      And I fill podcast details I want to add
      And I press "Create Podcast"
      Then I should see the podcast card page
      When I press "Return"
      Then I should see the the new podcast on my podcast table

