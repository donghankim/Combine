class PodcastsController < ApplicationController
  before_action :set_podcast, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :isVerified, only: [:edit, :update, :destroy]
  # GET /podcasts or /podcasts.json
  def index
    @podcasts = Podcast.all
  end

  # GET /podcasts/1 or /podcasts/1.json
  def show
  end

  # GET /podcasts/new
  def new
    @podcast = current_user.podcast.build
  end

  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts or /podcasts.json
  def create
    @podcast = current_user.podcast.build(podcast_params)

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to podcast_url(@podcast), notice: "Podcast was successfully created." }
        format.json { render :show, status: :created, location: @podcast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcasts/1 or /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to podcast_url(@podcast), notice: "Podcast was successfully updated." }
        format.json { render :show, status: :ok, location: @podcast }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1 or /podcasts/1.json
  def destroy
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Podcast was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def isVerified
    @poscast = current_user.podcast.find_by(id: params[:id])
    redirect_to root_path, notice: "Not Authorized To Edit or Delete This Podcast" if @podcast.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def podcast_params
      params.require(:podcast).permit(:user_id, :name, :company, :recent_episode, :genre, :rating)
    end
end
