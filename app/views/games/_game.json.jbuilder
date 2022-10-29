json.extract! game, :id, :user_id, :name, :company, :year, :genre, :rating, :created_at, :updated_at
json.url game_url(game, format: :json)
