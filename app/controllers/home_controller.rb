require 'uri'
require 'net/http'
require 'openssl'

# series, movie, game

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
      @userFriends = Friend.where("user_id =?", current_user.id)

      @moviesEmpty = isEmpty(@userMovies)
      @gamesEmpty = isEmpty(@userGames)
      @podcastsEmpty = isEmpty(@userPodcasts)
      @showsEmpty = isEmpty(@userShows)

      # process any search queries
      unless params[:query].nil?
        api_req = fetch_movie(params[:query])
        if api_req.key?("Error")
          flash[:notice] = "Could not find \"" + params[:query] + "\" in IMDB database..."
        else
          @mediaData = []
          api_req['Search'].each do |data|
            id_ = data["imdbID"]
            imdbRes = fetch_imdb(id_)
            if (not imdbRes.key?("Error"))
              @mediaData.append(imdbRes)
            end
          end
        end
      end
    end
  end

  def showImdb
    info = params[:mediaInfo]
    @type = info["Type"]
    @name = info["Title"]
    @poster = info["Poster"]
    @rating = info["imdbRating"]
    @year = info["Year"]
    @director = info["Director"]
    @actors = info["Actors"]
    @genre = info["Genre"]
    @plot = info["Plot"]
    @writer = info["Writer"]
    render "showImdb"
  end

  def isEmpty(record)
    return record.empty?
  end

  def friends
    if !user_signed_in?
      flash[:notice] = "You need to log in first!"
      redirect_to new_user_session_path
    end

    @friendsEmpty = false

    if user_signed_in?
      @userFriends = Friend.where("user_id =?", current_user.id)
      @users = User.where("id !=?", 0)

      @friendsEmpty = isEmpty(@userFriends)
    end
  end

  def recommendations
    if !user_signed_in?
      flash[:notice] = "You need to log in first!"
      redirect_to new_user_session_path
    end

    @friendsEmpty = false
    if user_signed_in?
      @userFriends = Friend.where("user_id =?", current_user.id)

      @friendsEmpty = isEmpty(@userFriends)
      if @friendsEmpty == false
        #keep track of how many times each genre is applicable
        @movieGenres = Hash.new(0)
        @showGenres = Hash.new(0)
        @gameGenres = Hash.new(0)

        #go through each friend
        @userFriends.each do |friend|
          #go through each piece of media
          Movie.where("user_id =?", friend.name).each do |movie|
            @genresArray = movie.genre.split
            #add each genre to the hash
            @genresArray.each do |genre|
              #ensure there are no commas
              genre.delete! ','
              @movieGenres[genre] = @movieGenres[genre] + 1
            end
          end

          TvShow.where("user_id =?", friend.name).each do |show|
            @genresArray = show.genre.split
            #add each genre to the hash
            @genresArray.each do |genre|
              #ensure there are no commas
              genre.delete! ','
              @showGenres[genre] = @showGenres[genre] + 1
            end
          end

          Game.where("user_id =?", friend.name).each do |game|
            @genresArray = game.genre.split
            #add each genre to the hash
            @genresArray.each do |genre|
              #ensure there are no commas
              genre.delete! ','
              @gameGenres[genre] = @gameGenres[genre] + 1
            end
          end
        end
        
        #MOVIES
        #if no friends have seen a movie, dont recommend anything
        @moviesEmpty = false

        if @movieGenres.empty?()
          @moviesEmpty = true
        
        else
          #the hash is created and the most popular genre stored below
          @mostPopularGenre = @movieGenres.max_by{|k,v| v}.first
            
          #go through every friend and make list of every item seen with that genre
          @applicableMedia = Array.new

          @userFriends.each do |friend|
            Movie.where("user_id =?", friend.name).each do |movie|
              @genresArray = movie.genre.split
              @genresArray.each do |genre|
                genre.delete! ','
                if genre == @mostPopularGenre
                  @applicableMedia.push movie
                end
              end
            end
          end

          @movieRecommendation = @applicableMedia.sample

          #who has seen this and is friends with the user
          @movieRecommendedBy = Array.new
          Movie.where("name =?", @movieRecommendation.name).each do |hasSeen|
            @poss = User.where("id =?", hasSeen.user_id).first
            if Friend.where("name =?", @poss.id).where("user_id =?", current_user.id).present?
              @movieRecommendedBy.push @poss
            end
          end
        end

        #SHOWS
        #if no friends have seen a game, dont recommend anything
        @showsEmpty = false

        if @showGenres.empty?()
          @showsEmpty = true
        
        else
          #the hash is created and the most popular genre stored below
          @mostPopularGenre = @showGenres.max_by{|k,v| v}.first
            
          #go through every friend and make list of every item seen with that genre
          @applicableMedia = Array.new

          @userFriends.each do |friend|
            TvShow.where("user_id =?", friend.name).each do |show|
              @genresArray = show.genre.split
              @genresArray.each do |genre|
                genre.delete! ','
                if genre == @mostPopularGenre
                  @applicableMedia.push show
                end
              end
            end
          end

          @showRecommendation = @applicableMedia.sample

          #who has seen this and is friends with the user
          @showRecommendedBy = Array.new
          TvShow.where("name =?", @showRecommendation.name).each do |hasSeen|
            @poss = User.where("id =?", hasSeen.user_id).first
            if Friend.where("name =?", @poss.id).where("user_id =?", current_user.id).present?
              @showRecommendedBy.push @poss
            end
          end
        end

        #GAMES
        #if no friends have seen a game, dont recommend anything
        @gamesEmpty = false

        if @gameGenres.empty?()
          @gamesEmpty = true
        
        else
          #the hash is created and the most popular genre stored below
          @mostPopularGenre = @gameGenres.max_by{|k,v| v}.first
            
          #go through every friend and make list of every item seen with that genre
          @applicableMedia = Array.new

          @userFriends.each do |friend|
            Game.where("user_id =?", friend.name).each do |game|
              @genresArray = game.genre.split
              @genresArray.each do |genre|
                genre.delete! ','
                if genre == @mostPopularGenre
                  @applicableMedia.push game
                end
              end
            end
          end

          @gameRecommendation = @applicableMedia.sample

          #who has seen this and is friends with the user
          @gameRecommendedBy = Array.new
          Game.where("name =?", @gameRecommendation.name).each do |hasSeen|
            @poss = User.where("id =?", hasSeen.user_id).first
            if Friend.where("name =?", @poss.id).where("user_id =?", current_user.id).present?
              @gameRecommendedBy.push @poss
            end
          end
        end

      end
    end
  end

  private
    # for rapidAPI request
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
      return JSON.parse(response.body)
    end

    # fetch IMDB
    def fetch_imdb(imdbID)
      endpoint = ERB::Util.url_encode(imdbID)
      url = URI("https://movie-database-alternative.p.rapidapi.com/?r=json&i=" + endpoint)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = '5e123f2c8dmshc41d6e06564d61dp107f8djsn8f0e356490a4'
      request["X-RapidAPI-Host"] = 'movie-database-alternative.p.rapidapi.com'

      response = http.request(request)
      return JSON.parse(response.body)
    end

end
