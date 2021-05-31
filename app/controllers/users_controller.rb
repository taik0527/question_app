class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user), notice: "ユーザー「#{@user.name}」を追加しました。"
    else
      render :new
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end

end
