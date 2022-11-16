class TvShowsController < ApplicationController
  before_action :set_tv_show, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :isVerified, only: [:edit, :update, :destroy]

  # GET /tv_shows or /tv_shows.json
  def index
    @tv_shows = TvShow.all
  end

  # GET /tv_shows/1 or /tv_shows/1.json
  def show
  end

  def addImdb
    @tv_show = current_user.tv_show.build
    @tv_show.name = params[:name]
    @tv_show.director = params[:director]
    @tv_show.show_stars = params[:show_stars]
    @tv_show.seasons = params[:seasons]
    @tv_show.genre = params[:genre]
    @tv_show.rating = params[:rating]

    respond_to do |format|
      if @tv_show.save
        format.html { redirect_to root_path, notice: "Series was successfully Added."}
        # format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tv_show.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tv_shows/new
  def new
    @tv_show = current_user.tv_show.build
  end

  # GET /tv_shows/1/edit
  def edit
  end

  # POST /tv_shows or /tv_shows.json
  def create
    @tv_show = current_user.tv_show.build(tv_show_params)

    respond_to do |format|
      if @tv_show.save
        format.html { redirect_to tv_show_url(@tv_show), notice: "Tv show was successfully created." }
        format.json { render :show, status: :created, location: @tv_show }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tv_show.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tv_shows/1 or /tv_shows/1.json
  def update
    respond_to do |format|
      if @tv_show.update(tv_show_params)
        format.html { redirect_to tv_show_url(@tv_show), notice: "Tv show was successfully updated." }
        format.json { render :show, status: :ok, location: @tv_show }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tv_show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tv_shows/1 or /tv_shows/1.json
  def destroy
    @tv_show.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Tv show was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def isVerified
    @tv_show = current_user.tv_show.find_by(id: params[:id])
    redirect_to movies_path, notice: "Not Authorized To Edit or Delete This Show" if @tv_show.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tv_show
      @tv_show = TvShow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tv_show_params
      params.require(:tv_show).permit(:user_id, :name, :director, :show_stars, :seasons, :genre, :rating)
    end
end
