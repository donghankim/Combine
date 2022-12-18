def create_media_visitor
    @media_user = User.create!({
               :email => "test@columbia.edu",
               :password => "test123",
               :password_confirmation => "test123"
            })
end

def create_friend_media_visitor
    @media_user_friend = User.create!({
               :email => "testsfriend@columbia.edu",
               :password => "test123",
               :password_confirmation => "test123"
            })
end
  
Given /^user has logged in$/ do
    create_media_visitor
    visit root_path
    click_on "Log In"
    fill_in "Email", :with => "test@columbia.edu"
    fill_in "Password", :with => "test123"
    click_on "Log In"
end

Given /^friend has logged in$/ do
    create_friend_media_visitor
    visit root_path
    click_on "Log In"
    fill_in "Email", :with => "testsfriend@columbia.edu"
    fill_in "Password", :with => "test123"
    click_on "Log In"
end

Given /^friend has added media$/ do
    fill_in "Search Anything!", :with => "harry"
    first(".searchArea").click_on("Search")
    first(".card").click_on("Add movie")

    click_on "Search"
    fill_in "Search Anything!", :with => "bojack"
    first(".searchArea").click_on("Search")
    first(".card").click_on("Add series")

    click_on "Search"
    fill_in "Search Anything!", :with => "minecraft"
    first(".searchArea").click_on("Search")
    first(".card").click_on("Add game")

    click_on "Add my own!"
    page.select('podcast', :from => 'medium_media_type')
    fill_in "Title", :with => "Podcast"
    fill_in "Genre", :with => "one, two, three"
    fill_in "Summary", :with => "Insert Summary"
    click_on "Create Medium"
end

Given /^they have logged out$/ do
    click_on "Sign Out"
end

When('I should see a request to log in') do
    expect(page).to have_content("You need to log in first!")
end
  
When('I press {string}') do |string|
    click_on string
end
  
When('I click a result') do
    first(".card").click_on("Show Details")
end
  
Then('I should see "Are you sure?"') do
    expect(page).to have_content("Are you sure?")
end