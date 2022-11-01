def create_game
  @new_game ||={
            :name => "Mario",
            :director => "someone",
            :year => "2010",
            :genre => "genre1, genre2",
            :rating => "10.5"
          }
end
  
When('I fill game details I want to add') do
  create_game
  fill_in "Game Title", :with => @new_game[:name]
  fill_in "Director", :with => @new_game[:director]
  fill_in "Year Released", :with => @new_game[:year]
  fill_in "Genre", :with => @new_game[:genre]
  fill_in "Rating", :with => @new_game[:rating]
end
  
Then('I should see the game card page') do
  expect(page).to have_content(@new_game[:name])
  expect(page).to have_content(@new_game[:rating])
  expect(page).to have_content(@new_game[:director])
end
  
Then('I should see the new game on my games table') do
  expect(page).to have_content(@new_game[:name])
  expect(page).to have_content(@new_game[:director])
  expect(page).to have_content(@new_game[:year])
  expect(page).to have_content(@new_game[:genre])
  expect(page).to have_content(@new_game[:rating])
end
  
Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end
  
