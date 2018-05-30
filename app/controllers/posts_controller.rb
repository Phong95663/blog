class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_post, only: [:show]
  before_action :correct_user, only: [:edit, :destroy, :update]

  def new
    @post = current_user.posts.build
  end

  def index
    @posts = Post.load_data_post.page(params[:page]).per Settings.post.per_page
  end

  def show
    @comments = @post.comments.all
    @comment = @post.comments.build
  end

  def edit; end

  def update
    if @post.update_attributes post_params
      flash[:success] = t ".susscess"
      redirect_to @post
    else
      render :edit
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = t ".susscess"
      redirect_to @post
    else
      render "static_pages/home"
    end
  end

  def destroy
    @post.destroy
    flash[:success] = t ".susscess"
    redirect_to current_user
  end

  def find_post
    @post = Post.find_by id: params[:id]
    return if @post
    flash.now[:danger] = t ".danger"
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
