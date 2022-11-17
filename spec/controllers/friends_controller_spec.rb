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
            response.should redirect_to home_friends_path
        end

        it "should not allow user to create a friend" do
            params = {
                :params => {
                    :friend => {
                        :email => 1,
                        :password => "test123",
                        :password_confirmation => "test123"
                    }
                }
            }
            expect {
                post :create, params
            }.to change(Friend, :count).by(0)
            response.should redirect_to home_friends_path
        end
    end

    # describe "DELETE /destroy" do
    #     login_user

    #     it "destroys the requested friend" do
    #         friend = Friend.create!({
    #             :name => 1,
    #             :user_id => 2,
    #         })

    #         expect {
    #             delete friend_url(friend)
    #         }.to change(Friend, :count).by(-1)
    #     end
    # end
end
