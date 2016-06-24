class PostsController < ApplicationController
before_action :find_user, only: [:create, :index]
before_action :find_user_and_post, only: [:show, :edit, :destroy, :update]

  def index
    @posts = @user.posts.order('created_at DESC')
  end

  def create
    @post = @user.posts.build(post_params)
    @post.save
    respond_to do |format|
      format.html {
        flash[:notice] = 'Post added.'
        redirect_to :back
      }
      format.js
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
    @post.destroy
    redirect_to authenticated_root_path
    flash[:notice] = 'Post deleted.'
  end


  def show_comments
    @user = User.where(id: params[:user_id]).last
    @post = Post.where(id: params[:id]).last
    respond_to do |format|
      if @post.comments.count < 20
        format.js
      else
        format.html {
          redirect_to @post
        }
      end
    end
  end

  def like
    @post = Post.find(params[:id])
    @user = current_user
    if @like = Like.find_by(likeable: @post, user: @user)
      @like.destroy
      respond_to do |format|
        format.html {
          flash[:success] = "Like Updated!"
          redirect_to :back
        }
        format.js
      end
    else
      Like.create(likeable: @post, user: @user, like: true)
      respond_to do |format|
        format.html {
          flash[:success] = "Like Updated!"
          redirect_to :back
        }
        format.js
      end
    end
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
