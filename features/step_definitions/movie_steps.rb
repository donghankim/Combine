require 'rubygems'
require 'selenium-webdriver'

def create_movie_visitor
  @movie_visitor ||= {
    :email    => "testaccount@columbia.edu",
    :password => "test123",
  }
end

def create_movie
  @new_movie ||={
    :name => "Avengers",
    :director => "someone",
    :movie_stars => "actor1, actor2, actor3",
    :year_released => "2010",
    :genre => "genre1, genre2",
    :rating => "10.5"
  }
end

Given /^user has logged in$/ do
  create_movie_visitor
  visit root_path
  click_on "Login"
  fill_in "Email", :with => @movie_visitor[:email]
  fill_in "Password", :with => @movie_visitor[:password]
  click_on "Log in"
end

When('I press {string}') do |string|
  click_on "Add Movie"
end

When('I fill movie details I want to add') do
  create_movie
  fill_in "movie_title", :with => @new_movie[:name]
  fill_in "director", :with => @new_movie[:director]
  fill_in "movie_stars", :with => @new_movie[:movie_stars]
  fill_in "year_released", :with => @new_movie[:year_released]
  fill_in "genre", :with => @new_movie[:genre]
  fill_in "rating", :with => @new_movie[:rating]
  click_on "Create Movie"
end

Then('I should see the movie card page') do
  expect(page).to have_content(@new_movie[:name])
  expect(page).to have_content(@new_movie[:director])
end

Then('I should see the the new movie on my movies table') do
  expect(page).to have_content("My Movies")
  expect(page).to have_content("My TV Shows")
  expect(page).to have_content("My Podcasts")
  expect(page).to have_content("My Games")
end
