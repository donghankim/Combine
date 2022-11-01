def create_podcast_visitor
    @podcast_user = User.create!({
               :email => "test@columbia.edu",
               :password => "test123",
               :password_confirmation => "test123"
             })
  end
  
  def create_podcast
    @new_podcast ||={
        :name => "Riverdale",
        :company => "someone",
        :episode => "5",
        :genre => "genre1, genre2",
        :rating => "10.5"
             }
  end
  
  Given /^user has logged in$/ do
    create_podcast_visitor
    visit root_path
    click_on "Log In"
    fill_in "Email", :with => "test@columbia.edu"
    fill_in "Password", :with => "test123"
    click_on "Log In"
  end
  
  
  When('I press {string}') do |string|
    click_on string
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
  end
  
  Then('I should see the the new podcast on my podcast table') do
    expect(page).to have_content(@new_podcast[:name])
    expect(page).to have_content(@new_podcast[:company])
    expect(page).to have_content(@new_podcast[:episode])
    expect(page).to have_content(@new_podcast[:genre])
    expect(page).to have_content(@new_podcast[:rating])
  end
  
  Then('I should see {string} podcast card page') do |string|
    expect(page).to have_content(string)
  end
  
  Then('I should not see {string}') do |string|
    expect(page).not_to have_content(string)
  end
