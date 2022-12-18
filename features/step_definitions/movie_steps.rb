def create_movie
    @new_movie ||={
              :title => "Harry Potter and the Deathly Hallows: Part 2",
              :genre => "Adventure, Family, Fantasy",
              :rating => "8.1",
              :media_type => "movie",
              :summary => "Harry, Ron, and Hermione search for Voldemort's remaining Horcruxes in their effort to destroy the Dark Lord as the final battle rages on at Hogwarts"
             }
  end
  
  When('I search for a movie') do
    fill_in "Search Anything!", :with => "harry"
    first(".searchArea").click_on("Search")
  end
  
  Then('I should not be allowed to add it') do
    expect(page).to have_content("already exists...")
  end

  When('I add a movie') do
    click_on "My Media"
    click_on "Add my own!"
    create_movie
    fill_in "Title", :with => @new_movie[:title]
    fill_in "Summary", :with => @new_movie[:summary]
    click_on "Create Medium"
  end
  
  When('I fill movie details I want to add') do
    create_movie
    fill_in "Title", :with => @new_movie[:title]
    fill_in "Summary", :with => @new_movie[:summary]
  end
  
  Then('I should see the new movie on my movies table') do
    create_movie
    expect(page).to have_content(@new_movie[:title])
    expect(page).to have_content(@new_movie[:summary])
  end
  
  Then('I should not see the movie') do
    expect(page).not_to have_content(@new_movie[:title])
  end