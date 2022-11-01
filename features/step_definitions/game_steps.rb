def create_game_visitor
    @movie_user = User.create!({
               :email => "test@columbia.edu",
               :password => "test123",
               :password_confirmation => "test123"
             })
  end
  
  def create_game
    @new_game ||={
              :name => "Mario",
              :director => "someone",
              :year => "2010",
              :genre => "genre1, genre2",
              :rating => "10.5"
             }
  end
  
  Given /^user has logged in$/ do
    create_game_visitor
    visit root_path
    click_on "Log In"
    fill_in "Email", :with => "test@columbia.edu"
    fill_in "Password", :with => "test123"
    click_on "Log In"
  end
  
  
  When('I press {string}') do |string|
    click_on string
  end
  
  When('I fill movie details I want to add') do
    create_game
    fill_in "Game Title", :with => @new_game[:name]
    fill_in "Director", :with => @new_game[:director]
    fill_in "Year Released", :with => @new_game[:year]
    fill_in "Genre", :with => @new_game[:genre]
    fill_in "Rating", :with => @new_game[:rating]
  end
  
  Then('I should see the movie card page') do
    expect(page).to have_content(@new_game[:name])
  end
  
  Then('I should see the the new movie on my movies table') do
    expect(page).to have_content(@new_game[:name])
    expect(page).to have_content(@new_game[:director])
    expect(page).to have_content(@new_game[:year])
    expect(page).to have_content(@new_game[:genre])
    expect(page).to have_content(@new_game[:rating])
  end
  
  Then('I should see {string} game card page') do |string|
    expect(page).to have_content(string)
  end
  
  Then('I should not see {string}') do |string|
    expect(page).not_to have_content(string)
  end
  
