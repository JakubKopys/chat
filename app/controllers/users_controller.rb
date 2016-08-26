class UsersController < ApplicationController
  def index
    if params[:friends]
      @users = User.includes(:requested_friendships).find(params[:friends]).unaccepted_friends
    else
      @users = User.all.includes(:requested_friendships)
    end

    if params[:search]
      @users = User.username_like("%#{params[:search]}%")
    end
  end

  def show
    @user = User.where(id: params[:id]).last
    @posts = @user.posts
  end

  def get_user
    render json: {name: current_user.username}
  end

end
