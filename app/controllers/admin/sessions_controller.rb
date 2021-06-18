class Admin::SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password]) && user.admin
      session[:user_id] = user.id
      session[:user_admin] = user.id
      redirect_to  admin_users_path, notice: "ログインしました"
    else
      render :new
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
