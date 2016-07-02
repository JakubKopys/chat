class HomeController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 4)
    @users = User.all
    @user = current_user
  end
end
