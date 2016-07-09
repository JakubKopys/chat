class FriendshipsController < ApplicationController

  def index
    @user = current_user
    @friendships = Friendship.all
  end

  def create
    friend = User.find(params[:user_id])

    Friendship.request(current_user, friend)

    redirect_to user_friendships_path(user_id: current_user.id)
  end

  def update
    @user = current_user
    @friend = User.find(params[:user_id])

    Friendship.accept(@user, @friend)

    redirect_to user_friendships_path(user_id: current_user.id)
  end

  def destroy
    @user = current_user
    @friendship = Friendship.find(params[:id])
    @friend = (@user != @friendship.user) ? @friendship.user : @friendship.friend
    Friendship.remove(@user, @friend)

    redirect_to user_friendships_path(user_id: current_user.id)
  end
end
