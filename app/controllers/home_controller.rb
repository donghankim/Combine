require 'uri'
require 'net/http'
require 'openssl'


class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to home_search_path
    end
  end

  def search
    unless params[:query].nil?
      api_req = fetch_movie(params[:query])
      if api_req.key?("Error")
        flash[:notice] = "Could not find \"" + params[:query] + "\" in IMDB database..."
      else
        @imdbResData = []
        api_req['Search'].each do |data|
          id_ = data["imdbID"]
          imdbRes = fetch_imdb(id_)
          if (not imdbRes.key?("Error"))
            @imdbResData.append(imdbRes)
          end
        end
      end
    end
  end

  def media
    if !user_signed_in?
      flash[:notice] = "You need to log in first!"
      redirect_to new_user_session_path
    end

    @all_types = ["movie", "series", "game", "podcast"]
    @selected_types = @all_types
    if params["commit"] == "Filter"
      @selected_types = params.select {|k, v| v == "1"}.keys
    end

    if user_signed_in?
      @userMedia = Medium.where(user_id: current_user.id)
      @media_to_show = []
      @userMedia.each do |m|
        if @selected_types.include? m[:media_type]
          @media_to_show.append(m)
        end
      end
    end
  end

  def showDetails
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
    @imdb_id = info["imdbID"]
  end

  def isEmpty(record)
    return record.empty?
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
        @podcastGenres = Hash.new(0)

        #go through each friend
        @userFriends.each do |friend|
          #go through each piece of media
          Medium.where("media_type =?", "movie").where("user_id =?", friend.name).each do |movie|
            @genresArray = movie.genre.split
            #add each genre to the hash
            @genresArray.each do |genre|
              #ensure there are no commas
              genre.delete! ','
              @movieGenres[genre] = @movieGenres[genre] + 1
            end
          end

          Medium.where("media_type =?", "series").where("user_id =?", friend.name).each do |show|
            @genresArray = show.genre.split
            @genresArray.each do |genre|
              genre.delete! ','
              @showGenres[genre] = @showGenres[genre] + 1
            end
          end

          Medium.where("media_type =?", "game").where("user_id =?", friend.name).each do |game|
            @genresArray = game.genre.split
            @genresArray.each do |genre|
              genre.delete! ','
              @gameGenres[genre] = @gameGenres[genre] + 1
            end
          end

          Medium.where("media_type =?", "podcast").where("user_id =?", friend.name).each do |podcast|
            @genresArray = podcast.genre.split
            @genresArray.each do |genre|
              genre.delete! ','
              @podcastGenres[genre] = @podcastGenres[genre] + 1
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
            Medium.where("media_type =?", "movie").where("user_id =?", friend.name).each do |movie|
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
          Medium.where("media_type =?", "movie").where("title =?", @movieRecommendation.title).each do |hasSeen|
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
            Medium.where("media_type =?", "series").where("user_id =?", friend.name).each do |show|
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
          Medium.where("media_type =?", "series").where("title =?", @showRecommendation.title).each do |hasSeen|
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
            Medium.where("media_type =?", "game").where("user_id =?", friend.name).each do |game|
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
          Medium.where("media_type =?", "game").where("title =?", @gameRecommendation.title).each do |hasSeen|
            @poss = User.where("id =?", hasSeen.user_id).first
            if Friend.where("name =?", @poss.id).where("user_id =?", current_user.id).present?
              @gameRecommendedBy.push @poss
            end
          end
        end

        #PODCASTS
        #if no friends have seen a podcast, dont recommend anything
        @podcastsEmpty = false

        if @podcastGenres.empty?()
          @podcastsEmpty = true

        else
          #the hash is created and the most popular genre stored below
          @mostPopularGenre = @podcastGenres.max_by{|k,v| v}.first

          #go through every friend and make list of every item seen with that genre
          @applicableMedia = Array.new

          @userFriends.each do |friend|
            Medium.where("media_type =?", "podcast").where("user_id =?", friend.name).each do |podcast|
              @genresArray = podcast.genre.split
              @genresArray.each do |genre|
                genre.delete! ','
                if genre == @mostPopularGenre
                  @applicableMedia.push podcast
                end
              end
            end
          end

          @podcastRecommendation = @applicableMedia.sample

          #who has seen this and is friends with the user
          @podcastRecommendedBy = Array.new
          Medium.where("media_type =?", "podcast").where("title =?", @podcastRecommendation.title).each do |hasSeen|
            @poss = User.where("id =?", hasSeen.user_id).first
            if Friend.where("name =?", @poss.id).where("user_id =?", current_user.id).present?
              @podcastRecommendedBy.push @poss
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
