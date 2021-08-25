class JobTradesmenApplicationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /jobs/1/job_tradesmen_applications/new
  def new
  end

  # POST /jobs/1/job_tradesmen_applications
  def create
    @job_tradesmen_application.job_id = params[:job_id]
    if @job_tradesmen_application.save
      redirect_to @job_tradesmen_application.job, notice: 'Application was successfully created.'
    else
      render :new
    end
  end

  # PATCH /jobs/1/job_tradesmen_applications/1
  def update
    @job = Job.find(params[:job_id])
    if params[:accepted]
      @job.tradesmen_profile_id = @job_tradesmen_application.tradesmen_profile_id
      @job.job_tradesmen_application_id = @job_tradesmen_application.id
      @job.active = true
      @job.status = "Accepted application"
      @job.save!
      redirect_to job_path(@job)
    else
      if @job_tradesmen_application.update(job_tradesmen_application_params)
        redirect_to job_path(@job)
      else
        redirect_to job_path(@job), notice: 'Failed to update job tradesmen application.'
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def job_tradesmen_application_params
    params.require(:job_tradesmen_application).permit(:job_id, :tradesmen_profile_id, :date, :accepted, :quote)
  end

end
