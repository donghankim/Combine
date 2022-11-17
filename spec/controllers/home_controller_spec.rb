require "rails_helper"
require_relative "../support/devise"

RSpec.describe HomeController, type: :controller do
    describe "show media page" do
        login_user

        it "should show the media page" do
            get :index
            response.should render_template('index')
        end
    end

    describe "show friend page when logged in" do
        login_user
        it "should show the friend page if logged in" do
            get :friends
            response.should render_template('friends')
        end
    end

    describe "dont show friend page when not logged in" do
        it "should not show not the friend page if not logged in" do
            get :friends
            response.should redirect_to(new_user_session_path)
        end
    end

    describe "show Imdb page when logged in" do
        login_user
        it "should show the Imdb page if logged in" do
            params = {
                :params => {
                    :mediaInfo => {
                        :Type => "Game",
                        :Title => "Mincraft",
                        :Poster => "12345",
                        :Rating => "100",
                        :Year => "2000",
                        :Director => "Jade Kaleel",
                        :Actors => "Jade and Friends",
                        :Genre => "Action, Adventure, Family, Fantasy, Romance, Sci-Fi",
                        :Plot => "Insert Plot here",
                        :Writer => "Combine Group",
                    }
                }
            }

            get :showImdb, params
            response.should render_template('showImdb')
        end
    end

    describe "dont show recommendations page when not logged in" do
        it "should not show the rec page if not logged in" do
            get :recommendations
            response.should redirect_to(new_user_session_path)
        end
    end
end
