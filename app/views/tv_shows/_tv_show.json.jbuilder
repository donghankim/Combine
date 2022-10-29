json.extract! tv_show, :id, :user_id, :name, :director, :show_stars, :seasons, :genre, :rating, :created_at, :updated_at
json.url tv_show_url(tv_show, format: :json)
