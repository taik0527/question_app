class Admin::UsersController < ApplicationController
  before_action :admin_required
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end
end
