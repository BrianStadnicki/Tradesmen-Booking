class JobTradesmenApplicationsController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  # GET /jobs/1/job_tradesmen_applications/new
  def new
    @job = Job.find(params[:job_id])
  end

  # POST /jobs/1/job_tradesmen_applications
  def create
    @job_tradesmen_application.job_id = params[:job_id]
    if @job_tradesmen_application.save

      @job_tradesmen_application.job.business.users.each do |user|
        send_notification user, "Tradesmen #{@job_tradesmen_application.tradesmen_profile.name} applied for a job", "They applied for #{@job_tradesmen_application.job.title}", "JobTradesmenApplication", "created"
      end

      redirect_to @job_tradesmen_application.job, notice: 'Application was successfully created.'
    else
      render :new
    end
  end

  # GET /jobs/1/job_tradesmen_applications/1/edit
  def edit
    @job = Job.find(params[:job_id])
    @job_tradesmen_application = @job.job_tradesmen_applications.where(tradesmen_profile: current_user.tradesmen_profile_belongs).first
  end

  # PATCH /jobs/1/job_tradesmen_applications/1
  def update
    @job = Job.find(params[:job_id])
    @job_tradesmen_application = JobTradesmenApplication.find(params[:id])
    if params[:accepted]
      @job.tradesmen_profile = @job_tradesmen_application.tradesmen_profile
      @job.job_tradesmen_application = @job_tradesmen_application
      @job.active = true
      @job.status = "Accepted application"
      @job.save!

      @job.tradesmen_profile.users.each do |user|
        send_notification user, "Job accepted", "#{@job.business.name} accepted your application for #{@job.title}", "Jobs", "accepted"
      end

      redirect_to job_path(@job)
    else
      if @job_tradesmen_application.update(job_tradesmen_application_params)

        @job_tradesmen_application.job.business.users.each do |user|
          send_notification user, "Tradesmen #{@job_tradesmen_application.tradesmen_profile.name} changed their application for a job", "They changed their application for #{@job_tradesmen_application.job.title}", "JobTradesmenApplication", "updated"
        end

        redirect_to job_path(@job)
      else
        redirect_to job_path(@job), notice: 'Failed to update job tradesmen application.'
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def job_tradesmen_application_params
    params.require(:job_tradesmen_application).permit(:job_id, :tradesmen_profile_id, :date, :morning, :afternoon, :accepted, :quote)
  end

end
