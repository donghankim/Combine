Feature: Add New Movie
    Background:
      Given user has logged in

    Scenario: Add a Movie
      When I press "Add Movie"
      And I fill movie details I want to add
      And I press "Create Movie"
      Then I should see the movie card page
      When I press "Return"
      Then I should see the new movie on my movies table