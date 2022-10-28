json.extract! movie, :id, :name, :director, :movie_stars, :year, :genre, :rating, :created_at, :updated_at
json.url movie_url(movie, format: :json)
