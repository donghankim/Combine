#adds the user to the database
Given /(.*) user exists/ do |user|
  #TODO
end

Given /a movie/ do
  @movieName = "The Incredibles"
end

And /add the movie "(.*)"/ do |movie|
  Movie.create movie
end

#confirms you are on a certain page
Given /^(?:|I )am on (.+)$/ do |page_name|
  visit page_name
end

#how many movies are in the user's profile
Then /(.*) types of media should exist/ do | n_movies |
  expect(Movie.count).to eq n_movies.to_i
end

#a certain type of media is on the page
Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end
