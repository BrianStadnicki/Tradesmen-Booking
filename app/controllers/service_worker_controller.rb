class ServiceWorkerController < ApplicationController
  skip_authorization_check
  protect_from_forgery except: [:service_worker]
  skip_before_action :get_notifications

  def service_worker
  end

  def manifest
  end

end
