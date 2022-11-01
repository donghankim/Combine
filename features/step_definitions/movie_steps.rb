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
  expect(page).to have_content(@new_movie[:director])
  expect(page).to have_content(@new_movie[:rating])
end

Then('I should see the new movie on my movies table') do
  expect(page).to have_content(@new_movie[:name])
  expect(page).to have_content(@new_movie[:director])
  expect(page).to have_content(@new_movie[:movie_stars])
  expect(page).to have_content(@new_movie[:year_released])
  expect(page).to have_content(@new_movie[:genre])
  expect(page).to have_content(@new_movie[:rating])
end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end
