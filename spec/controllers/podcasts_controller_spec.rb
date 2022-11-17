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
end