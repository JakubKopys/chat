class PostsController < ApplicationController
before_action :find_user, only: [:create, :index]
before_action :find_user_and_post, only: [:show, :edit, :destroy, :update]

  def index
    @posts = @user.posts.order('created_at DESC')
  end

  def create
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post added.'
      redirect_to authenticated_root_path
    else
      render 'new'
      flash[:notice] = 'Invalid post, try again.'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to authenticated_root_path
      flash[:success] = 'Post updated.'
    else
      render 'edit'
      flash[:success] = 'Invalid edit.'
    end

  end

  def destroy
    @post.delete
    redirect_to authenticated_root_path
    flash[:notice] = 'Post deleted.'
  end


private

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def find_user
    @user = User.where(id: params[:user_id]).last
  end

  def find_user_and_post
    @user = User.where(id: params[:user_id]).last
    @post = @user.posts.where(id: params[:id]).last
  end


end
