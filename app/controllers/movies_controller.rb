class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :addImdb]
  before_action :isVerified, only: [:edit, :update, :destroy]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  def showImdb
    movie_info = params[:movieInfo]
    @name = movie_info["Title"]
    @poster = movie_info["Poster"]
    @rating = movie_info["imdbRating"]
    @year = movie_info["Year"]
    @director = movie_info["Director"]
    @actors = movie_info["Actors"]
    @genre = movie_info["Genre"]
    @plot = movie_info["Plot"]
    render "showImdb"
  end

  def addImdb
    @movie = current_user.movie.build
    @movie.name = params[:name]
    @movie.director = params[:director]
    @movie.movie_stars = params[:movie_stars]
    @movie.year = params[:year]
    @movie.genre = params[:genre]
    @movie.rating = params[:rating]

    respond_to do |format|
      if @movie.save
        format.html { redirect_to root_path, notice: "Movie was successfully Added." }
        # format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /movies/new
  def new
    @movie = current_user.movie.build
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = current_user.movie.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def isVerified
    @movie = current_user.movie.find_by(id: params[:id])
    redirect_to movies_path, notice: "Not Authorized To Edit or Delete This Movie" if @movie.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:name, :director, :movie_stars, :year, :genre, :rating, :user_id)
    end
end
