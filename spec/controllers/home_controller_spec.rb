require 'rails_helper'
require_relative "../support/devise"

RSpec.describe HomeController, type: :controller do

  describe 'Show homepage when first visting Combine' do
    it 'displays Combine homepage' do
      get :index
      response.should render_template('index')
    end
  end

  describe 'Logged in users are automatically directed to the search page' do
    login_user
    it 'should show the IMDB search page' do
      get :index
      expect(response).to redirect_to(home_search_path)
    end
  end
  
  describe 'Test IMDB search functionality' do
    login_user
    context 'When logged in users search IMDB' do
      it 'Avengers Endgame should return 6 results' do
        post :search, params: { query: "Avengers Endgame" }
        expect(assigns(:imdbResData)).to be_an_instance_of(Array)
        expect(assigns(:imdbResData)).to have_attributes(length: 6)
      end
    end
  end
  
  describe 'If user has not logged in' do
    it 'accessing media page should redirect them to login page' do
      get :media
      expect(flash).to have_attributes(notice: "You need to log in first!")
      response.should redirect_to(new_user_session_path)
    end
  
    it 'accessing recommendations page should redirect them to login page' do
      get :recommendations
      expect(flash).to have_attributes(notice: "You need to log in first!")
      response.should redirect_to(new_user_session_path)
    end

  end

  describe 'Show users their registered media content' do
    login_user
    it 'All media (series, game, and podcast) should show' do
      get :media
      expect(assigns(:all_types)).to be_an_instance_of(Array)
      expect(assigns(:all_types)).to eq(["movie", "series", "game", "podcast"])
      response.should render_template('media')
    end 
  end
  
  describe "Check showDetails functionality" do
    login_user
    it "sets the correct instance variables" do
      get :showDetails, params: { mediaInfo: { "Type" => "movie", "Title" => "some movie", "imdbID" => "tt1234567" } }

      expect(assigns(:type)).to eq("movie")
      expect(assigns(:name)).to eq("some movie")
      expect(assigns(:imdb_id)).to eq("tt1234567")
    end
  end

  describe "Verify isEmpty functionality" do
    it "returns true for an empty record" do
      expect(controller.isEmpty([])).to be(true)
      expect(controller.isEmpty({})).to be(true)
    end

    it "returns false for a non-empty record" do
      expect(controller.isEmpty([1, 2, 3])).to be(false)
      expect(controller.isEmpty({ a: 1, b: 2 })).to be(false)
    end
  end

end
