class ServiceWorkerController < ApplicationController
  authorize_resource
  protect_from_forgery except: [:service_worker, :manifest]

  def service_worker
  end

  def manifest
  end

end
