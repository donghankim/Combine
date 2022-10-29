json.extract! podcast, :id, :user_id, :name, :company, :recent_episode, :genre, :rating, :created_at, :updated_at
json.url podcast_url(podcast, format: :json)
