class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to questions_url, notice: "サインアップが完了しました"
    else
      flash.now[:danger] = "サインアップに失敗しました"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
end
