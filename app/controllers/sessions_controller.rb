class SessionsController < ApplicationController
  def login_form
  end

  def login
  end

  def create
    @auth_hash = request.env['omniauth.auth']

    @user = User.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])

    if @user
      session[:user_id] = @user.id
      flash[:success] = "#{@user.username} is logged in"
    else
      provider = @auth_hash['provider']

        @user = User.new uid: @auth_hash['uid'], provider: @auth_hash['provider'], username: @auth_hash['info']['nickname'], email: @auth_hash['info']['email']
      end
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome #{@user.username}"
      else
        flash[:error] = "Unable to save user!"
      end
    end
    redirect_to root_path
  end

  def logout
  end
end
