class JobTradesmenApplicationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /job_tradesmen_applications/new
  def new
  end

  # POST /job_tradesmen_applications
  def create
    @job_tradesmen_application.job_id = params[:job_id]
    if @job_tradesmen_application.save
      redirect_to @job_tradesmen_application.job, notice: 'Application was successfully created.'
    else
      render :new
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def job_tradesmen_application_params
    params.require(:job_tradesmen_application).permit(:job_id, :tradesmen_profile_id, :date)
  end

end
