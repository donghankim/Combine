Feature: Add New Movie
    Background:
        Given user has logged in

    Scenario: Add a Custom Movie
        When I press "My Media"
        When I press "Add my own!"
        And I fill movie details I want to add
        And I press "Create Medium"
        Then I should see the new movie on my movies table

    Scenario: Add a Movie Using IMDB
        When I search for a movie
        And I click a result
        Then I should see the movie info
        And I press "Add movie"
        Then I should see the new movie on my movies table

    Scenario: Delete a Movie
        When I add a movie
        When I press "Remove"
        Then I should not see the movie

    Scenario: Add the Same Movie Using IMDB
        When I search for a movie
        And I click a result
        And I press "Add movie"
        And I press "Search"
        And I search for a movie
        And I click a result
        And I press "Add movie"
        Then I should not be allowed to add it

    Scenario: Log Out
        When they have logged out
        And I press "My Media"
        Then I should see a request to log in