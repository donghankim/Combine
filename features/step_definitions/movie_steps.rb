def create_movie
  @new_movie ||={
            :name => "Harry Potter and the Deathly Hallows: Part 2",
            :director => "David Yates",
            :movie_stars => "Daniel Radcliffe, Emma Watson, Rupert Grint",
            :year => "2011",
            :genre => "Adventure, Family, Fantasy",
            :rating => ""
           }
end

def edit_movie
  @edited_movie ||={
            :name => "Harry Potter and the Deathly Hallows: Part 3",
            :director => "David Yates II",
            :movie_stars => "Daniel Radcliffe, Emma Watson, Rupert Grint, Mario",
            :year => "2012",
            :genre => "Adventure, Family, Fantasy, Cool",
            :rating => "100.5"
           }
end

When('I search for a movie') do
  fill_in "Search Anything!", :with => "harry"
  click_on "Enter"
end

When('I add a movie') do
  click_on "Add Movie"
  create_movie
  fill_in "Movie Title", :with => @new_movie[:name]
  fill_in "Director", :with => @new_movie[:director]
  fill_in "Movie Stars", :with => @new_movie[:movie_stars]
  fill_in "Year Released", :with => @new_movie[:year]
  fill_in "Genre", :with => @new_movie[:genre]
  fill_in "Rating", :with => @new_movie[:rating]
  click_on "Create Movie"
  click_on "Return"
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

When('I fill movie details I want to edit') do
  edit_movie
  fill_in "Movie Title", :with => @edited_movie[:name]
  fill_in "Director", :with => @edited_movie[:director]
  fill_in "Movie Stars", :with => @edited_movie[:movie_stars]
  fill_in "Year Released", :with => @edited_movie[:year]
  fill_in "Genre", :with => @edited_movie[:genre]
  fill_in "Rating", :with => @edited_movie[:rating]
end

Then('I should see the movie card page') do
  expect(page).to have_content(@new_movie[:name])
  expect(page).to have_content(@new_movie[:director])
  expect(page).to have_content(@new_movie[:rating])
end

Then('I should see the edited movie card page') do
  expect(page).to have_content(@edited_movie[:name])
  expect(page).to have_content(@edited_movie[:director])
  expect(page).to have_content(@edited_movie[:rating])
end

Then('I should see the new movie on my movies table') do
  create_movie
  expect(page).to have_content(@new_movie[:name])
  expect(page).to have_content(@new_movie[:director])
  expect(page).to have_content(@new_movie[:movie_stars])
  expect(page).to have_content(@new_movie[:year_released])
  expect(page).to have_content(@new_movie[:genre])
  expect(page).to have_content(@new_movie[:rating])
end

Then('I should see the edited movie on my movies table') do
  expect(page).to have_content(@edited_movie[:name])
  expect(page).to have_content(@edited_movie[:director])
  expect(page).to have_content(@edited_movie[:movie_stars])
  expect(page).to have_content(@edited_movie[:year_released])
  expect(page).to have_content(@edited_movie[:genre])
  expect(page).to have_content(@edited_movie[:rating])
end

And ('I click on the new movie') do
  click_on @new_movie[:name]
end

Then('I should not see the movie') do
  expect(page).not_to have_content(@new_movie[:name])
end
