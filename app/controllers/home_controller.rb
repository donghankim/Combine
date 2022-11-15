require 'uri'
require 'net/http'
require 'openssl'

class HomeController < ApplicationController
  def index
    @moviesEmpty = false
    @gamesEmpty = false
    @podcastsEmpty = false
    @showsEmpty = false

    if user_signed_in?
      @userMovies = Movie.where("user_id =?", current_user.id)
      @userGames = Game.where("user_id =?", current_user.id)
      @userPodcasts = Podcast.where("user_id =?", current_user.id)
      @userShows = TvShow.where("user_id =?", current_user.id)

      @moviesEmpty = isEmpty(@userMovies)
      @gamesEmpty = isEmpty(@userGames)
      @podcastsEmpty = isEmpty(@userPodcasts)
      @showsEmpty = isEmpty(@userShows)
    end
  end

  def isEmpty(record)
    return record.empty?
  end

  def friends
    if !user_signed_in?
      flash[:notice] = "You need to log in first!"
      redirect_to new_user_session_path
    end
  end

  def recommendations
    if !user_signed_in?
      flash[:notice] = "You need to log in first!"
      redirect_to new_user_session_path
    end
  end

  def search
    flash[:notice] = "Works"
    
  end

  private
      # rapidAPI request
    def fetch_movie(name)
      endpoint = ERB::Util.url_encode(name)
      url = URI("https://movie-database-alternative.p.rapidapi.com/?s=" + endpoint + "&r=json&page=1")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = '5e123f2c8dmshc41d6e06564d61dp107f8djsn8f0e356490a4'
      request["X-RapidAPI-Host"] = 'movie-database-alternative.p.rapidapi.com'

      response = http.request(request)

      puts response.read_body
    end

end
