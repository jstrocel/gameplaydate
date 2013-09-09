class FriendshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:friendship][:followed_id])
    current_user.follow!(@user)
    if @user.following?(current_user)
      FriendNotify.accept_friend_request(@user.id, current_user.id ).deliver
    else
      FriendNotify.friend_request(current_user.id, @user.id).deliver
    end
    track_activity @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Friendship.find(params[:id]).followed
    current_user.unfollow!(@user)
    track_activity @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end