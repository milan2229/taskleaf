class SessionsController < ApplicationController
  skip_before_action :login_required
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    #送られてきたメールアドレスでユーザーを探す
    #↓ユーザーが見つかった場合は送られてきたパスワードによる認証をauthenticate(認証)メソッドを使って行う
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
