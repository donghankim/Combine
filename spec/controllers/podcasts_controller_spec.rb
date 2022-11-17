require "rails_helper"
require_relative "../support/devise"

RSpec.describe PodcastsController, type: :controller do
    describe "show form to add a podcast" do
        login_user

        context "from login user" do
            it "should show the form for user to create new podcast information" do
                get :new
                expect(response).to have_http_status(:success)
                response.should render_template('new')
            end
        end
    end

    describe 'create a podcast' do
        login_user

        it "should allow user to create a podcast" do
            params = {
                :params => {
                    :podcast => {
                        :name => "Riverdale",
                        :company => "someone",
                        :episode => "episode one, episode two",
                        :genre => "genre1, genre2",
                        :rating => "10.5"
                    }
                }
            }

            post :create, params
            response.should redirect_to podcast_url(1)
        end
    end
end