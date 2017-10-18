class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

  private
  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def authenticate
    unless session[:user_id]
      redirect_to root_path
    end
  end

end
