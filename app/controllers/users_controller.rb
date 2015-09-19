class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :login, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts_received.where(topic_id: nil).includes(:replies).paginate(page: params[:page])
    @reply = @user.posts.build
  end

  def destroy
    @user = User.find(params[:id])
    if current_user?@user
      redirect_to root_path
    else
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to user_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :email, :avatar,
                                    :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def login
      redirect_to root_path if signed_in?
    end
end
