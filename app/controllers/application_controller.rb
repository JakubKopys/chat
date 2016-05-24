class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    login_params = [:username, :email, :password, :password_confirmation, :remember_me]
    registration_params = [:email, :username, :password, :password_confirmation, :avatar]
    update_params  = [:email, :username, :password, :password_confirmation, :current_password, :avatar]
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(login_params) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(registration_params) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(update_params) }
  end
end
