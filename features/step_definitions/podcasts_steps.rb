def create_podcast
  @new_podcast ||={
              :name => "Riverdale",
              :company => "someone",
              :episode => "episode one, episode two",
              :genre => "genre1, genre2",
              :rating => "10.5"
             }
end

def edit_podcast
  @edited_podcast ||={
              :name => "Riverdale 2.0",
              :company => "someone better",
              :episode => "episode one, episode two, episode three",
              :genre => "genre1, genre2, genre3",
              :rating => "100.5"
             }
end

When('I add a podcast') do
  click_on "Add Podcast"
  create_podcast
  fill_in "Podcast Name", :with => @new_podcast[:name]
  fill_in "Company", :with => @new_podcast[:company]
  fill_in "Recent Episode", :with => @new_podcast[:episode]
  fill_in "Genre", :with => @new_podcast[:genre]
  fill_in "Rating", :with => @new_podcast[:rating]
  click_on "Create Podcast"
  click_on "Return"
end
  
When('I fill podcast details I want to add') do
  create_podcast
  fill_in "Podcast Name", :with => @new_podcast[:name]
  fill_in "Company", :with => @new_podcast[:company]
  fill_in "Recent Episode", :with => @new_podcast[:episode]
  fill_in "Genre", :with => @new_podcast[:genre]
  fill_in "Rating", :with => @new_podcast[:rating]
end

When('I fill podcast details I want to edit') do
  edit_podcast
  fill_in "Podcast Name", :with => @edited_podcast[:name]
  fill_in "Company", :with => @edited_podcast[:company]
  fill_in "Recent Episode", :with => @edited_podcast[:episode]
  fill_in "Genre", :with => @edited_podcast[:genre]
  fill_in "Rating", :with => @edited_podcast[:rating]
end
  
Then('I should see the podcast card page') do
  expect(page).to have_content(@new_podcast[:name])
  expect(page).to have_content(@new_podcast[:rating])
  expect(page).to have_content(@new_podcast[:company])
end

Then('I should see the edited podcast card page') do
  expect(page).to have_content(@edited_podcast[:name])
  expect(page).to have_content(@edited_podcast[:rating])
  expect(page).to have_content(@edited_podcast[:company])
end
  
Then('I should see the new podcast on my podcasts table') do
  expect(page).to have_content(@new_podcast[:name])
  expect(page).to have_content(@new_podcast[:company])
  expect(page).to have_content(@new_podcast[:episode])
  expect(page).to have_content(@new_podcast[:genre])
  expect(page).to have_content(@new_podcast[:rating])
end

Then('I should see the edited podcast on my podcasts table') do
  expect(page).to have_content(@edited_podcast[:name])
  expect(page).to have_content(@edited_podcast[:company])
  expect(page).to have_content(@edited_podcast[:episode])
  expect(page).to have_content(@edited_podcast[:genre])
  expect(page).to have_content(@edited_podcast[:rating])
end

And ('I click on the new podcast') do
  click_on @new_podcast[:name]
end
  
Then('I should not see the podcast') do
  expect(page).not_to have_content(@new_podcast[:name])
end
