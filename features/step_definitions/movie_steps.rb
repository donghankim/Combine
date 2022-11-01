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

def edit_movie
  @edited_movie ||={
            :name => "Avengers 2.0",
            :director => "someone better",
            :movie_stars => "actor1, actor2, actor3, actor4",
            :year => "2020",
            :genre => "genre1, genre2, genre3",
            :rating => "100.5"
           }
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
