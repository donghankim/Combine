require "rails_helper"
require_relative "../support/devise"

RSpec.describe GamesController, type: :controller do

    describe 'list all games' do
        login_user
        it 'should find and list all games' do
            get :index
            expect(response).to redirect_to(root_path)
        end
    end

    describe 'show form to add a game' do
        login_user
        it 'should show the form for user to create new game information' do
            get :new
            expect(response).to have_http_status(:success)
            response.should render_template('new')
        end
    end

    describe 'add a new game' do
        it 'should create a game successfully' do
            # game ||= {
            #     :name => "Mario",
            #     :director => "someone",
            #     :year => "2010",
            #     :genre => "genre1, genre2",
            #     :rating => "10.5"
            # }
            # game = double(
            #     'Game',
            #     :name => "Mario",
            #     :director => "someone",
            #     :year => "2010",
            #     :genre => "genre1, genre2",
            #     :rating => "10.5"
            # )
            # newGame = Game.create(name: "Anything", company: "Lorem ipsum", year: "2012", genre: "g1, g2, g3", rating: 5)
            params = {
                :name => "Mario",
                :company => "someone",
                :year => "2010",
                :genre => "genre1, genre2",
                :rating => "10.5"
            }

            #Game.should_receive(:create!).and_return(game)
            # post :create, :game_params => params
            post :create, :game => params
            response.should redirect_to(game_path)
        end
    end

    describe 'update a game' do
        it 'should save the updated game information' do
            game = double(
                'Game',
                :name => "Mario",
                :director => "someone",
                :year => "2010",
                :genre => "genre1, genre2",
                :rating => "10.5"
            )

            Game.should_receive(:find).and_return(game)
            game.should_receive(:update)
            put :update, :game => game
            response.should redirect_to game_path(game)
        end
    end

    describe 'delete a game' do
        it 'should delete the game' do
            game = double(
                'Game',
                :name => "Mario",
                :director => "someone",
                :year => "2010",
                :genre => "genre1, genre2",
                :rating => "10.5"
            )
            game.should_receive(:destroy)
            delete :destroy
            response.should redirect_to(game_path)
        end
    end

    describe 'verify game deletion / edits' do
        it 'should pass if the user is verified' do
            game = double(
                'Game',
                :name => "Mario",
                :director => "someone",
                :year => "2010",
                :genre => "genre1, genre2",
                :rating => "10.5"
            )
            Game.should_receive(:find_by).with('1').and_return(game)
            response.should redirect_to(game_path)
        end
    end
end
