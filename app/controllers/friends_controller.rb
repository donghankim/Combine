require 'levenshtein'

class FriendsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :isVerified, only: [:destroy]

  def index
    if !user_signed_in?
      flash[:notice] = "You need to log in first!"
      redirect_to new_user_session_path
    end

    @friend_uid = []
    @myfriends = []
    if user_signed_in?
      temp = Friend.where(user_id: current_user.id)
      temp.each do |fid|
        @myfriends.append([fid, fid.name])
        @friend_uid.append(fid.name)
      end
    end

    @friend_search = []
    unless params[:friend_email].nil?
      all_users = User.all
      token = params[:friend_email]
      all_users.each do |user|
        if user.id == current_user.id or @friend_uid.include? user.id
          next
        else
          user_email = User.find_by_id(user.id).email
          sim_val = Levenshtein.normalized_distance token, user_email
          if sim_val < 0.15
            @friend_search.append([user_email, user.id])
          end
        end
      end

      if @friend_search.length == 0
        flash[:notice] = "Could not find any viable users to add..."
      end
    end
  end

  # post
  def addFriend
    @friend = current_user.friend.build
    @friend.user_id = current_user.id
    @friend.name = params[:friend_id]

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friends_path, notice: "Friend was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /friends/1 or /friends/1.json
  def show
    uid = params[:friend_uid]
    @friendEmail = User.find_by_id(uid).email
    @media_to_show = Medium.where(user_id: uid)
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    removeFriend = Friend.find_by_id(params[:id])
    removeFriend.destroy

    respond_to do |format|
      format.html { redirect_to friends_path, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def isVerified
    @friend = current_user.friend.find_by(id: params[:id])
    redirect_to home_friends_path, notice: "Not Authorized To Edit or Delete This Friend" if @friend.nil?
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
