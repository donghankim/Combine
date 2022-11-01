def create_podcast
  @new_podcast ||={
              :name => "Riverdale",
              :company => "someone",
              :episode => "episode one, episode two",
              :genre => "genre1, genre2",
              :rating => "10.5"
             }
end
  
When('I fill podcast details I want to add') do
  create_podcast
  fill_in "Podcast Name", :with => @new_podcast[:name]
  fill_in "Company", :with => @new_podcast[:company]
  fill_in "Recent Episode", :with => @new_podcast[:episode]
  fill_in "Genre", :with => @new_podcast[:genre]
  fill_in "Rating", :with => @new_podcast[:rating]
end
  
Then('I should see the podcast card page') do
  expect(page).to have_content(@new_podcast[:name])
  expect(page).to have_content(@new_podcast[:rating])
  expect(page).to have_content(@new_podcast[:company])
end
  
Then('I should see the new podcast on my podcast table') do
  expect(page).to have_content(@new_podcast[:name])
  expect(page).to have_content(@new_podcast[:company])
  expect(page).to have_content(@new_podcast[:episode])
  expect(page).to have_content(@new_podcast[:genre])
  expect(page).to have_content(@new_podcast[:rating])
end
  
Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end
