class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_comment, except: [:create]

  def create
    @comment = Comment.create comment_params
    set_params
    respond_to do |format|
      format.html {redirect_to @comment.post}
      format.js
    end
  end

  def edit
    set_params
    respond_to do |format|
      format.html {redirect_to @comment.post}
      format.js
    end
  end

  def update
    @comment.update_attributes comment_params
    set_params
    respond_to do |format|
      format.html {redirect_to @comment.post}
      format.js
    end
  end

  def destroy
    @comment.destroy
    set_params
    respond_to do |format|
      format.html {redirect_to @comment.post}
      format.js
    end
  end

  def find_comment
     @comment = Comment.find_by id: params[:id]
  end

  def set_params
    @comments = @comment.post.comments.all
    @post = @comment.post
  end
  private

  def comment_params
    params.require(:comment).permit :id, :user_id, :post_id, :content
  end
end
