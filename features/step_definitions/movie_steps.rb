def create_movie_visitor
  @movie_user = User.create!({
             :email => "test@columbia.edu",
             :password => "test123",
             :password_confirmation => "test123"
           })
end

def create_movie
  @new_movie ||={
            :name => "Avengers",
            :director => "someone",
            :movie_stars => "actor1, actor2, actor3",
            :year => "2010",
            :genre => "genre1, genre2",
            :rating => "10.5"
           }
end

Given /^user has logged in$/ do
  create_movie_visitor
  visit root_path
  click_on "Log In"
  fill_in "Email", :with => "test@columbia.edu"
  fill_in "Password", :with => "test123"
  click_on "Log In"
end


When('I press {string}') do |string|
  click_on string
end

When('I fill movie details I want to add') do
  create_movie
  fill_in "Movie Title", :with => @new_movie[:name]
  fill_in "Director", :with => @new_movie[:director]
  fill_in "Movie Stars", :with => @new_movie[:movie_stars]
  fill_in "Year Released", :with => @new_movie[:year]
  fill_in "Genre", :with => @new_movie[:genre]
  fill_in "Rating", :with => @new_movie[:rating]
end

Then('I should see the movie card page') do
  expect(page).to have_content(@new_movie[:name])
end

Then('I should see the the new movie on my movies table') do
  expect(page).to have_content(@new_movie[:name])
  expect(page).to have_content(@new_movie[:director])
  expect(page).to have_content(@new_movie[:movie_stars])
  expect(page).to have_content(@new_movie[:year_released])
  expect(page).to have_content(@new_movie[:genre])
  expect(page).to have_content(@new_movie[:rating])
end

Then('I should see {string} movie card page') do |string|
  expect(page).to have_content(string)
end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end
