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

    Scenario: Edit a Movie
      When I add a movie
      And I click on the new movie
      And I press "Edit Movie"
      And I fill movie details I want to edit
      When I press "Update Movie"
      Then I should see the edited movie card page
      When I press "Return"
      Then I should see the edited movie on my movies table

    Scenario: Delete a Movie
      When I add a movie
      And I click on the new movie
      When I press "Remove"
      Then I should not see the movie