def create_game
  @new_game ||={
            :name => "Mario",
            :director => "someone",
            :year => "2010",
            :genre => "genre1, genre2",
            :rating => "10.5"
          }
end

def edit_game
  @edited_game ||={
            :name => "Mario 2.0",
            :director => "someone better",
            :year => "2020",
            :genre => "genre1, genre2, genre3",
            :rating => "100.5"
          }
end

When('I add a game') do
  click_on "Add Game"
  create_game
  fill_in "Game Title", :with => @new_game[:name]
  fill_in "Director", :with => @new_game[:director]
  fill_in "Year Released", :with => @new_game[:year]
  fill_in "Genre", :with => @new_game[:genre]
  fill_in "Rating", :with => @new_game[:rating]
  click_on "Create Game"
  click_on "Return"
end
  
When('I fill game details I want to add') do
  create_game
  fill_in "Game Title", :with => @new_game[:name]
  fill_in "Director", :with => @new_game[:director]
  fill_in "Year Released", :with => @new_game[:year]
  fill_in "Genre", :with => @new_game[:genre]
  fill_in "Rating", :with => @new_game[:rating]
end

When('I fill game details I want to edit') do
  edit_game
  fill_in "Game Title", :with => @edited_game[:name]
  fill_in "Director", :with => @edited_game[:director]
  fill_in "Year Released", :with => @edited_game[:year]
  fill_in "Genre", :with => @edited_game[:genre]
  fill_in "Rating", :with => @edited_game[:rating]
end
  
Then('I should see the game card page') do
  expect(page).to have_content(@new_game[:name])
  expect(page).to have_content(@new_game[:rating])
  expect(page).to have_content(@new_game[:director])
end

Then('I should see the edited game card page') do
  expect(page).to have_content(@edited_game[:name])
  expect(page).to have_content(@edited_game[:rating])
  expect(page).to have_content(@edited_game[:director])
end
  
Then('I should see the new game on my games table') do
  expect(page).to have_content(@new_game[:name])
  expect(page).to have_content(@new_game[:director])
  expect(page).to have_content(@new_game[:year])
  expect(page).to have_content(@new_game[:genre])
  expect(page).to have_content(@new_game[:rating])
end

Then('I should see the edited game on my games table') do
  expect(page).to have_content(@edited_game[:name])
  expect(page).to have_content(@edited_game[:director])
  expect(page).to have_content(@edited_game[:year])
  expect(page).to have_content(@edited_game[:genre])
  expect(page).to have_content(@edited_game[:rating])
end

And ('I click on the new game') do
  click_on @new_game[:name]
end
  
Then('I should not see the game') do
  expect(page).not_to have_content(@new_game[:name])
end