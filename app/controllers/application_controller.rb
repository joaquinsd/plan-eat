class ApplicationController < ActionController::Base
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :lastname
    devise_parameter_sanitizer.for(:account_update) << :current_password

    devise_parameter_sanitizer.for(:sign_up) << [:name, :lastname, :client]
  end
end
