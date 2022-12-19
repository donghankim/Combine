require 'rails_helper'
require_relative "../support/devise"

RSpec.describe MediaController, type: :controller do
  describe 'Get users media page' do
    login_user
    it 'redirects to the home_media_path' do
      get :index
      expect(response).to redirect_to(home_media_path)
    end
  end

  describe 'Get page for allowing users to adding user defined media' do
    login_user
    it 'assigns a new Medium to @medium' do
      get :new
      expect(assigns(:medium)).to be_a_new(Medium)
    end
  end

  describe 'Validate and create user defined media' do
    login_user
    medium_params = {
      :params => {
        :medium => {
          :media_type => "movie",
          :title => "user movie",
          :director => "user director",
          :genre => "Action, Commedy",
          :rating => 8,
          :summary =>"user summary",
        }
      }
    }

    context 'with valid user entered params' do
      it 'creates a new Medium' do
        expect {
          post :create, medium_params
        }.to change(Medium, :count).by(1)
      end

      it 'assigns a newly created medium as @medium' do
        post :create, medium_params
        expect(assigns(:medium)).to be_a(Medium)
        expect(assigns(:medium)).to be_persisted
      end

      it 'redirects to the home_media_path' do
        post :create, medium_params
          expect(response).to redirect_to(home_media_path)
      end
    end
  end


  describe 'Validate and allow users to add media from IMDB' do
    let(:user) { FactoryBot.create(:user) }
    let(:medium_attributes) do
      {
        imdb_id: 'tt0111161',
        poster_url: 'https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
        media_type: 'Movie',
        title: 'The Shawshank Redemption',
        director: 'Frank Darabont',
        genre: 'Crime, Drama',
        rating: '9.2',
        summary: 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.'
      }
    end

    before do
      sign_in user
    end

    context "when the IMDB medium does not already exist" do
      it "creates a new medium" do
        expect { get :createImdb, params: { user_id: user.id, **medium_attributes } }.to change(Medium, :count).by(1)
      end

      it "redirects to the media list" do
        post :createImdb, params: { user_id: user.id, **medium_attributes }
        expect(response).to redirect_to(home_media_path)
      end
    end

    context "when the medium already exists" do
      before do
        FactoryBot.create(:medium, user: user, imdb_id: medium_attributes[:imdb_id])
      end

      it "does not create a new medium" do
        expect { get :createImdb, params: { user_id: user.id, **medium_attributes } }.to change(Medium, :count).by(0)
      end

      it "redirects to the media list" do
        get :createImdb, params: { user_id: user.id, **medium_attributes }
        expect(response).to redirect_to(home_media_path)
      end
    end
  end

  describe "Allow validated users to remove media" do
    let(:user) { FactoryBot.create(:user) }
    let!(:medium) { FactoryBot.create(:medium, user: user) }

    before do
      sign_in user
    end

    it "destroys the requested medium" do
      expect { delete :destroy, params: { id: medium.id } }.to change(Medium, :count).by(-1)
    end

    it "redirects to the media list" do
      delete :destroy, params: { id: medium.id }
      expect(response).to redirect_to(home_media_path)
    end
  end
end
