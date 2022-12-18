Given ('another user exists') do
    @media_user_friend = User.create!({
               :email => "testsfriend@columbia.edu",
               :password => "test123",
               :password_confirmation => "test123"
            })
end

Given ('I am on the friends page') do
    click_on "Friends"
end

When ('I search a friend') do
    fill_in "Friend Email", :with => @media_user_friend.email
    first(".searchingFriend").click_on("Search")
end

When ('I should see my friends information') do 
    expect(page).to have_content(@media_user_friend[:email])
    expect(page).to have_content("No media content registered...")
end
  
When('I should see my new friend in my friends list') do
    expect(page).to have_content(@media_user_friend[:email])
end

Then('I should not see the friend') do
    expect(page).not_to have_content(@media_user_friend[:email])
end

When('I add myself as a friend') do
    fill_in "Friend Email", :with => @media_user.id
    first(".searchingFriend").click_on("Search")
end

Then('I should see an error') do
    expect(page).to have_content("Could not find any viable users to add...")
end

When('I add a non-existant user') do
    fill_in "Friend Email", :with => "hi@gmail.com"
    first(".searchingFriend").click_on("Search")
end