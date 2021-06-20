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
      redirect_to users_path, notice: "ユーザー「#{@user.name}」を追加しました。"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation, :admin)
  end
end
