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

end
