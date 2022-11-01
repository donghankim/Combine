Feature: Add New Tv-show
    Background:
      Given user has logged in

    Scenario: Add a Tv-show
      When I press "Add Tv-show"
      And I fill Tv-show details I want to add
      And I press "Create Tv-show"
      Then I should see the Tv-show card page
      When I press "Return"
      Then I should see the the new mTv-show on my Tv-show table

