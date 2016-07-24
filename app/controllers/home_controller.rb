class HomeController < ApplicationController
  autocomplete :user, :username, limit: 10
  def index
    #@posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 4)
    @posts = current_user.feed.order('created_at DESC').paginate(:page => params[:page], :per_page => 4)
    @users = User.all
  end
end
