def create_tv_show
  @new_tv_show ||={
              :name => "BoJack Horseman",
              :director => "N/A",
              :show_stars => "Will Arnett, Amy Sedaris, Alison Brie",
              :number_seasons => "2014",
              :genre => "Animation, Comedy, Drama",
              :rating => ""
             }
end

def edit_tv_show
  @edited_tv_show ||={
              :name => "BoJack Horseman But Better",
              :director => "Combine Group",
              :show_stars => "Will Arnett, Amy Sedaris, Alison Brie, Us",
              :number_seasons => "2020",
              :genre => "Animation, Comedy, Drama, So Dramatic",
              :rating => "1000"
             }
end

When('I search for a tv-show') do
  fill_in "Search Anything!", :with => "bojack"
  click_on "Enter"
end

When('I add a tv-show') do
  click_on "Add TV Show"
  create_tv_show
  fill_in "Show Title", :with => @new_tv_show[:name]
  fill_in "Director", :with => @new_tv_show[:director]
  fill_in "Show Stars", :with => @new_tv_show[:show_stars]
  fill_in "Number of Seasons", :with => @new_tv_show[:number_seasons]
  fill_in "Genre", :with => @new_tv_show[:genre]
  fill_in "Rating", :with => @new_tv_show[:rating]
  click_on "Create Tv show"
  click_on "Return"
end
  
When('I fill tv-show details I want to add') do
  create_tv_show
  fill_in "Show Title", :with => @new_tv_show[:name]
  fill_in "Director", :with => @new_tv_show[:director]
  fill_in "Show Stars", :with => @new_tv_show[:show_stars]
  fill_in "Number of Seasons", :with => @new_tv_show[:number_seasons]
  fill_in "Genre", :with => @new_tv_show[:genre]
  fill_in "Rating", :with => @new_tv_show[:rating]
end

When('I fill tv-show details I want to edit') do
  edit_tv_show
  fill_in "Show Title", :with => @edited_tv_show[:name]
  fill_in "Director", :with => @edited_tv_show[:director]
  fill_in "Show Stars", :with => @edited_tv_show[:show_stars]
  fill_in "Number of Seasons", :with => @edited_tv_show[:number_seasons]
  fill_in "Genre", :with => @edited_tv_show[:genre]
  fill_in "Rating", :with => @edited_tv_show[:rating]
end
  
Then('I should see the tv-show card page') do
  expect(page).to have_content(@new_tv_show[:name])
  expect(page).to have_content(@new_tv_show[:rating])
  expect(page).to have_content(@new_tv_show[:director])
end

Then('I should see the edited tv-show card page') do
  expect(page).to have_content(@edited_tv_show[:name])
  expect(page).to have_content(@edited_tv_show[:rating])
  expect(page).to have_content(@edited_tv_show[:director])
end
  
Then('I should see the new tv-show on my tv-shows table') do
  create_tv_show
  expect(page).to have_content(@new_tv_show[:name])
  expect(page).to have_content(@new_tv_show[:director])
  expect(page).to have_content(@new_tv_show[:show_stars])
  expect(page).to have_content(@new_tv_show[:number_seasons])
  expect(page).to have_content(@new_tv_show[:genre])
  expect(page).to have_content(@new_tv_show[:rating])
end

Then('I should see the edited tv-show on my tv-shows table') do
  expect(page).to have_content(@edited_tv_show[:name])
  expect(page).to have_content(@edited_tv_show[:director])
  expect(page).to have_content(@edited_tv_show[:show_stars])
  expect(page).to have_content(@edited_tv_show[:number_seasons])
  expect(page).to have_content(@edited_tv_show[:genre])
  expect(page).to have_content(@edited_tv_show[:rating])
end

And ('I click on the new tv-show') do
  click_on @new_tv_show[:name]
end
  
Then('I should not see the tv-show') do
  expect(page).not_to have_content(@new_tv_show[:name])
end