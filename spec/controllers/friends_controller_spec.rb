require "rails_helper"
require_relative "../support/devise"

RSpec.describe FriendsController, type: :controller do
    describe "show form to add a friend" do
        login_user

        context "from login user" do
            it "should show the form for user to create new friend" do
                get :new
                expect(response).to have_http_status(:success)
                response.should render_template('new')
            end
        end
    end

    describe 'create a friend' do
        login_user

        it "should allow user to create a friend" do
            params = {
                :params => {
                    :friend => {
                        :email => "testsfriend@columbia.edu",
                        :password => "test123",
                        :password_confirmation => "test123"
                    }
                }
            }

            post :create, params
            response.should redirect_to(home_friends_path)
        end
    end
end
