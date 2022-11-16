class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :isVerified, only: [:edit, :update, :destroy]
  # GET /games or /games.json
  def index
    redirect_to root_path
  end

  # GET /games/1 or /games/1.json
  def show
  end

  def addImdb
  #params.require(:game).permit(:user_id, :name, :company, :year, :genre, :rating)
    @game = current_user.game.build
    @game.name = params[:name]
    @game.company = params[:writer]
    @game.year = params[:year]
    @game.genre = params[:genre]
    @game.rating = params[:rating]

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully added." }
        # format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /games/new
  def new
    @game = current_user.game.build
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = current_user.game.build(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def isVerified
    @game = current_user.game.find_by(id: params[:id])
    redirect_to game_path, notice: "Not Authorized To Edit or Delete This Game" if @game.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:user_id, :name, :company, :year, :genre, :rating)
    end
end
