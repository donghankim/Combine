class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :isVerified, only: [:edit, :update, :destroy]
  before_action :canAdd, only: [:create]

  # GET /friends or /friends.json
  def index
    @friends = Friend.all
  end

  # GET /friends/1 or /friends/1.json
  def show
    @friendEmail = User.where("id =?", @friend.name)

    @friendsMovies = Movie.where("user_id =?", @friend.name)
    @friendsGames = Game.where("user_id =?", @friend.name)
    @friendsPodcasts = Podcast.where("user_id =?", @friend.name)
    @friendsShows = TvShow.where("user_id =?", @friend.name)

    @friendsMoviesEmpty = isEmpty(@friendsMovies)
    @friendsGamesEmpty = isEmpty(@friendsGames)
    @friendsPodcastsEmpty = isEmpty(@friendsPodcasts)
    @friendsShowsEmpty = isEmpty(@friendsShows)
  end

  def isEmpty(record)
    return record.empty?
  end

  # GET /friends/new
  def new
    @friend = current_user.friend.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    @friend = current_user.friend.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to home_friends_path, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def isVerified
    @friend = current_user.friend.find_by(id: params[:id])
    redirect_to home_friends_path, notice: "Not Authorized To Edit or Delete This Friend" if @friend.nil?
  end

  def canAdd
    @friend = User.where("id =?", friend_params['name']).first
    @alrExists = false
    @allFriends = Friend.where("user_id =?", current_user.id)
    @allFriends.each do |f|
      if f.name == @friend.id
        @alrExists = true
      end
    end

    if @friend.nil?
      redirect_to home_friends_path, notice: "Please add an existing user as a friend"
    elsif @friend.id == current_user.id
      redirect_to home_friends_path, notice: "You can't add yourself as a friend"
    else
      redirect_to home_friends_path, notice: "You already have this friend" if @alrExists == true
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:name, :user_id)
    end
end
