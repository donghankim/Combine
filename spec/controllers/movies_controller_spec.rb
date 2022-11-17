require "rails_helper"
require_relative "../support/devise"

RSpec.describe MoviesController, type: :controller do
    describe "show form to add a movie" do
        login_user

        context "from login user" do
            it "should show the form for user to create new movie information" do
                get :new
                expect(response).to have_http_status(:success)
                response.should render_template('new')
            end
        end
    end
    
    describe 'create a movie' do
        login_user

        it "should allow user to create a movie" do
            params = {
                :params => {
                    :movie => {
                        :name => "Harry Potter and the Deathly Hallows: Part 2",
                        :director => "David Yates",
                        :movie_stars => "Daniel Radcliffe, Emma Watson, Rupert Grint",
                        :year => "2011",
                        :genre => "Adventure, Family, Fantasy",
                        :rating => "10"
                    }
                }
            }

            post :create, params
            response.should redirect_to movie_url(1)
        end
    end

    describe "show movie imdb page when logged in" do
        login_user
        it "should show the game movie page if logged in" do
            params = {
                :params => {
                    :movie => {
                        :name => "Harry Potter and the Deathly Hallows: Part 2",
                        :director => "David Yates",
                        :movie_stars => "Daniel Radcliffe, Emma Watson, Rupert Grint",
                        :year => "2011",
                        :genre => "Adventure, Family, Fantasy",
                        :rating => "10"
                    }
                }
            }

            get :addImdb, params
            response.should redirect_to root_path
        end
    end
end