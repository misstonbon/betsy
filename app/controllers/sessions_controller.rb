class SessionsController < ApplicationController
  def login_form
  end

  def login
    name = params[:name]
    if name and user = User.find_by(name: name)
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Successfully logged in as existing user #{user.name}"
      user.merchant_status = false
    else
      user = User.new(name: name)
      if user.save
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Successfully created new user #{user.user} with ID #{user.id}"
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = "Could not log in"
        flash.now[:messages] = user.errors.messages
        render "login_form", status: :bad_request
        return
      end
    end
    redirect_to root_path
  end

  def create
    @auth_hash = request.env['omniauth.auth']

    @user = User.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])

    if @user
      @user.merchant_status = true
      session[:user_id] = @user.id
      flash[:success] = "#{@user.name} is logged in"
    else
      @user = User.new uid: @auth_hash['uid'], provider: @auth_hash['provider'], name: @auth_hash['info']['nickname'], email: @auth_hash['info']['email']
      @user.merchant_status = true
    end
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name}"
    else
      flash[:error] = "Unable to save user!"
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end

end
