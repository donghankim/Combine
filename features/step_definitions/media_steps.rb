def create_media_visitor
    @media_user = User.create!({
               :email => "test@columbia.edu",
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
  
When('I press {string}') do |string|
    click_on string
end
  
When('I click a result') do
    first(".card").click_on("Show Details")
end
  
Then('I should see "Are you sure?"') do
    expect(page).to have_content("Are you sure?")
end