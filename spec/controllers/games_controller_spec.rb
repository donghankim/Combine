require "rails_helper"
require_relative "../support/devise"

RSpec.describe GamesController, type: :controller do
    describe "show form to add a game" do
        login_user

        context "from login user" do
            it "should show the form for user to create new game information" do
                get :new
                expect(response).to have_http_status(:success)
                response.should render_template('new')
            end
        end
    end

    describe 'create a game' do
        login_user

        it "should allow user to create a game" do
            params = {
                :params => {
                    :game => {
                        :name => "Minecraft",
                        :director => "Markus Persson",
                        :year => "2009",
                        :genre => "Action, Adventure, Family, Fantasy, Romance, Sci-Fi",
                        :rating => "10"
                    }
                }
            }

            post :create, params
            response.should redirect_to game_url(1)
        end
    end

    describe "show game imdb page when logged in" do
        login_user
        it "should show the game imdb page if logged in" do
            params = {
                :params => {
                    :game => {
                        :name => "Minecraft",
                        :director => "Markus Persson",
                        :year => "2009",
                        :genre => "Action, Adventure, Family, Fantasy, Romance, Sci-Fi",
                        :rating => ""
                    }
                }
            }

            get :addImdb, params
            response.should redirect_to game_url(1)
        end
    end
end