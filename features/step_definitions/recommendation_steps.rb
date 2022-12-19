Given ('they are friends') do
    click_on "Friends"
    fill_in "Friend Email", :with => @media_user_friend.email
    first(".searchingFriend").click_on("Search")
    click_on("Add Friend")
    click_on "Recommendations"
end

Given ('I am on the recommendations page') do
    click_on "Recommendations"
end

When ('I delete my friend') do
    click_on "Friends"
    click_on "Remove"
end

When ('I should see no recommendations') do
    expect(page).to have_content("You have not added any friends so we cant recommend anything...")
end