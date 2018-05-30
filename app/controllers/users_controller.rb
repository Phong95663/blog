class UsersController < ApplicationController
  before_action :find_user, except: [:new, :index]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.load_data.page(params[:page]).per Settings.user.per_page
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".info"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".susscess"
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    @posts = @user.posts.order_by_created_at
                                  .page(params[:page])
                                  .per Settings.post.per_page
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:danger] = t ".notfound"
  end

  def following
    @title = "Following"
    @users = @user.following.page params[:page]
    render :show_follow
  end

  def followers
    @title = "Followers"
    @users = @user.followers.page params[:page]
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
