require 'rails_helper'

describe GamesController do

    describe 'list all games' do
        it 'should find and list all games' do
            get :index
            response.should render_template('index')
        end
    end
end