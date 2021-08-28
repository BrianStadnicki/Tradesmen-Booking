class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  check_authorization unless: :devise_controller?

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

  def send_notification(user, title, body, type)
    notification_subscription = JSON.parse(user.notification_subscription)

    Webpush.payload_send(
      message: "{\"title\": \"#{title}\", \"body\": \"#{body}\", \"type\": #{type.to_json}}",
      endpoint: notification_subscription['endpoint'],
      p256dh: notification_subscription['keys']['p256dh'],
      auth: notification_subscription['keys']['auth'],
      vapid: {
        subject: NOTIFICATIONS['vapid']['subject'],
        public_key: NOTIFICATIONS['vapid']['public_key'],
        private_key: NOTIFICATIONS['vapid']['private_key']
      },
      ssl_timeout: 5,
      open_timeout: 5,
      read_timeout: 5
    )
  end

end
