Feature: Add a media type to the user's profile

  I recently consumed some new media
  And I want to add it to my profile
  So that my friends can see it

Background: the user exists

  Given test@columbia.edu user exists:
  And  I am on the Combine home page
  Then 0 types of media should exist

Scenario: add a movie
  # enter step(s) to go to add movie page
  When  I am on the new movie page

  # enter step(s) to add movie to a profile
  Given a movie
  And add the movie "The Incredibles"
  And  I am on the Combine home page

  # enter step(s) to ensure that the movie is created
  Then I should see "The Incredibles"

  # enter step(s) to ensure that other movies are not visible
