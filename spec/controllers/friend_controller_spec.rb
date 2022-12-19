require 'rails_helper'
require_relative "../support/devise"

RSpec.describe FriendsController, type: :controller do
  
  describe 'Redirect non-logged in users to the login page' do
    it 'redirects users to the login page' do
      get :index
      response.should redirect_to(new_user_session_path)
    end

  end

  describe 'Allow logged in users to view their friends' do
    login_user
    it 'should show the friend page if logged in' do
      get :index
      response.should render_template('index')
    end
  end   

  describe 'Add a new friend' do
    let(:user) { FactoryBot.create(:user) }
    let(:friend_id) { '123456' }

    before do
      sign_in user
    end

    it 'creates a new friend' do
      expect { post :addFriend, params: { friend_id: friend_id } }.to change(Friend, :count).by(1)
    end

    it 'redirects to the friends list' do
      post :addFriend, params: { friend_id: friend_id }
      expect(response).to redirect_to(friends_path)
    end
  end


=begin
  describe "Show user friends media content" do
    let(:user) { FactoryBot.create(:user) }
    let(:friend) { FactoryBot.create(:friend, user: user) }
    let!(:medium) { FactoryBot.create(:medium, user_id: friend.name) }

    before do
      sign_in user
    end

    it "assigns the requested friend's email to @friendEmail" do
      get :show, params: { friend_uid: friend.name }
      expect(assigns(:friendEmail)).to eq(User.find_by_id(friend.name).email)
    end

    it "assigns the requested friend's media to @media_to_show" do
      get :show, params: { friend_uid: friend.name }
      expect(assigns(:media_to_show)).to eq(Medium.where(user_id: friend.name))
    end
  end
=end

  describe 'Remove an existing friend' do
    let(:user) { FactoryBot.create(:user) }
    let!(:friend) { FactoryBot.create(:friend, user: user) }

    before do
      sign_in user
    end

    it 'destroys the requested friend' do
      expect { delete :destroy, params: { id: friend.id } }.to change(Friend, :count).by(-1)
    end

    it 'redirects to the friends list' do
      delete :destroy, params: { id: friend.id }
      expect(response).to redirect_to(friends_path)
    end
  end


end
