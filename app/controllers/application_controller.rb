class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  check_authorization unless: :devise_controller?
  before_action :get_unread_notifications_count


  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    if current_user.nil?
      session[:next] = request.fullpath
      redirect_to login_url, alert: 'You have to log in to continue.'
    else
      render template: 'public/403', status: 403, layout: true
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :phone, :role_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :phone, :role_id])
    devise_parameter_sanitizer.permit(:invite, keys: [:name, :email, :phone, :role_id, :business_id, :tradesmen_profile_id])
  end

  def send_notification(user, title, body, category, type)
    notification = Notification.create!({ user: user, title: title, body: body, type_category: category, type_type: type, read: false, datetime: DateTime.now })
    Rails.logger.debug "Sending notification to #{user.id} #{user.name} with title: #{title};body: #{body};category: #{category};type:#{type}"
    return unless user.notification_subscription
    NotifierJob.perform_later notification
  end

  def get_unread_notifications_count
    @unread_notifications_count = Notification.where(user: current_user, read: false).count
  end

  def after_sign_in_path_for(resource)
    session[:sign_in] = true
    super
  end

end
