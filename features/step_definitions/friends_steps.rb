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

When ('I add a friend') do
    click_on "Add Friend"
    fill_in "Friend ID", :with => @media_user_friend.id
    click_on "Create Friend"
end

When ('I should see my friends information') do 
    expect(page).to have_content(@media_user_friend[:email])
    expect(page).to have_content(@media_user_friend.id)
    expect(page).to have_content("Movies")
    expect(page).to have_content("TV Shows")
    expect(page).to have_content("Podcasts")
    expect(page).to have_content("Games")
end
  
When('I should see my new friend in my friends list') do
    expect(page).to have_content(@media_user_friend[:email])
    expect(page).to have_content(@media_user_friend.id)
end

And('I click on the new friend') do
    click_on @media_user_friend.id
end

Then('I should not see the friend') do
    expect(page).not_to have_content(@media_user_friend[:email])
end

When('I add myself as a friend') do
    click_on "Add Friend"
    fill_in "Friend ID", :with => @media_user.id
    click_on "Create Friend"
end

Then('I should see an error about adding myself') do
    expect(page).to have_content("You can't add yourself as a friend")
end

Then('I should see an error saying {string}') do |string|
    expect(page).to have_content(string)
end

When('I add a non-existant user') do
    click_on "Add Friend"
    fill_in "Friend ID", :with => 10000
    click_on "Create Friend"
end