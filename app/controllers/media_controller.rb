class MediaController < ApplicationController
  before_action :set_medium, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :isVerified, only: [:edit, :update, :destroy]

  def index
    redirect_to home_media_path
  end

  # GET /media/new
  def new
    @medium = current_user.media.build
  end

  # GET /media/1/edit for user defined media
  def edit
  end

  def createImdb
    # check to see if imdb data already exists

    if Medium.where(user_id: current_user.id, imdb_id: params[:imdb_id]).length > 0
      flash[:notice] = params[:title] + " already exists..."
      redirect_to home_media_path
    else
      @medium = current_user.media.build
      @medium.imdb_id = params[:imdb_id]
      @medium.poster_url = params[:poster_url]
      @medium.media_type = params[:media_type]
      @medium.title = params[:title]
      @medium.director = params[:director]
      @medium.genre = params[:genre]
      @medium.rating = params[:rating]
      @medium.summary = params[:summary]

      respond_to do |format|
        if @medium.save
          format.html { redirect_to home_media_path, notice: @medium.title + " was successfully added." }
          # format.json { render :show, status: :created, location: @medium }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @medium.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # POST /media or /media.json for user defined media
  def create
    @medium = current_user.media.build(medium_params)
    if @medium["summary"] == 0
      @medium["summary"] = "Not Provided..."
    end

    respond_to do |format|
      if @medium.save
        format.html { redirect_to home_media_path, notice: "Media was successfully added." }
        # format.json { render :show, status: :created, location: @medium }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media/1 or /media/1.json for user defined media
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.html { redirect_to medium_url(@medium), notice: "Media was successfully updated." }
        format.json { render :show, status: :ok, location: @medium }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1 or /media/1.json
  def destroy
    @medium.destroy

    respond_to do |format|
      format.html { redirect_to home_media_path, notice: "Media was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medium
      @medium = Medium.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def medium_params
      params.require(:medium).permit(:user_id, :imdb_id, :poster_url, :media_type, :title, :director, :genre, :summary, :rating)
    end

    def isVerified
      @medium = current_user.media.find_by(id: params[:id])
      redirect_to home_media_path, notice: "Not Authorized To Edit or Delete This Media" if @medium.nil?
    end
end
