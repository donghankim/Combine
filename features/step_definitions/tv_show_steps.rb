def create_tv_show_visitor
    @tv_show_user = User.create!({
               :email => "test@columbia.edu",
               :password => "test123",
               :password_confirmation => "test123"
             })
  end
  
  def create_tv_show
    @new_tv_show ||={
              :name => "Riverdale",
              :director => "someone",
              :show_stars => "actor1, actor2, actor3",
              :number_seasons => "10",
              :genre => "genre1, genre2",
              :rating => "10.5"
             }
  end
  
  
  Given /^user has logged in$/ do
    create_tv_show_visitor
    visit root_path
    click_on "Log In"
    fill_in "Email", :with => "test@columbia.edu"
    fill_in "Password", :with => "test123"
    click_on "Log In"
  end
  
  
  When('I press {string}') do |string|
    click_on string
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
  
  Then('I should see the tv_show card page') do
    expect(page).to have_content(@new_tv_show[:name])
  end
  
  Then('I should see the the new movie on my movies table') do
    expect(page).to have_content(@new_tv_show[:name])
    expect(page).to have_content(@new_tv_show[:director])
    expect(page).to have_content(@new_tv_show[:show_stars])
    expect(page).to have_content(@new_tv_show[:number_seasons])
    expect(page).to have_content(@new_tv_show[:genre])
    expect(page).to have_content(@new_tv_show[:rating])
  end
  
  Then('I should see {string} tv_show card page') do |string|
    expect(page).to have_content(string)
  end
  
  Then('I should not see {string}') do |string|
    expect(page).not_to have_content(string)
  end
  
