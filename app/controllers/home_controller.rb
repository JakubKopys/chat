class HomeController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC')
    @users = User.all
    @user = current_user
  end
end
