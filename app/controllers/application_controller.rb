class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      session[:next] = request.fullpath
      redirect_to login_url, alert: 'You have to log in to continue.'
    else
      render template: 'public/403', status: 403, layout: true
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :address, :phone, :phone2, :date_of_birth, :role_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :address, :phone, :phone2, :date_of_birth, :role_id])
  end
end
