class ServiceWorkerController < ApplicationController
  authorize_resource
  protect_from_forgery except: [:service_worker, :manifest]
  skip_before_action :get_notifications

  def service_worker
  end

  def manifest
  end

end
