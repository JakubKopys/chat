class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.html {
        flash[:notice] = 'Comment added.'
        redirect_to :back
      }
      format.js
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to authenticated_root_path
  end

  def edit
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    respond_to do |f|
      f.js
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update comment_params
    respond_to do |f|
      f.html {
        redirect_to authenticated_root_path
      }
      f.js
    end
  end

  def like
    @comment = Comment.find(params[:id])
    @user = current_user
    if @like = Like.find_by(likeable: @comment, user: @user)
      @like.destroy
      respond_to do |format|
        format.js
      end
    else
      Like.create(likeable: @comment, user: @user, like: true)
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_user
    @user = current_user
  end
end
