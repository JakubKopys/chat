class HomeController < ApplicationController
  autocomplete :user, :username, limit: 10
  def index
    #@posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 4)
    @posts = current_user.feed.includes(:user).paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
    @users = User.all
    respond_to do |format|
      format.html
      format.js
    end
  end
end
