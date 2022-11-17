require "rails_helper"
require_relative "../support/devise"

RSpec.describe TvShowsController, type: :controller do
    describe "show form to add a tv show" do
        login_user

        context "from login user" do
            it "should show the form for user to create new tv show information" do
                get :new
                expect(response).to have_http_status(:success)
                response.should render_template('new')
            end
        end
    end

    describe 'create a tv show' do
        login_user

        it "should allow user to create a tv show" do
            params = {
                :params => {
                    :tv_show => {
                        :name => "BoJack Horseman",
                        :director => "N/A",
                        :show_stars => "Will Arnett, Amy Sedaris, Alison Brie",
                        :number_seasons => "2014",
                        :genre => "Animation, Comedy, Drama",
                        :rating => "10"
                    }
                }
            }

            post :create, params
            response.should redirect_to tv_show_url(1)
        end
    end

    describe "show game imdb page when logged in" do
        login_user
        it "should show the game imdb page if logged in" do
            params = {
                :params => {
                    :tv_show => {
                        :name => "BoJack Horseman",
                        :director => "N/A",
                        :show_stars => "Will Arnett, Amy Sedaris, Alison Brie",
                        :number_seasons => "2014",
                        :genre => "Animation, Comedy, Drama",
                        :rating => "10"
                    }
                }
            }

            get :addImdb, params
            response.should redirect_to root_path
        end
    end
end