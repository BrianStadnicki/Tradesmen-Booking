class JobsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /jobs
  def index
    index_eager_load
  end

  # GET /jobs/mine
  def mine
    index_eager_load
  end

  # GET /jobs/mine_active
  def mine_active
    index_eager_load
  end

  # GET /jobs/1
  def show
  end

  # GET /jobs/new
  def new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  def create
    @job.active |= true
    @job.status |= "Awaiting applications"
    @job.status_been_started |= false
    @job.status_been_completed |= false
    @job.business_id = @current_user.business_belongs.id unless @current_user.admin?

    if @job.save

      @job.business.tradesmen.includes(:users).each do |tradesmen|
        tradesmen.users.each do |user|
          send_notification user, 'Job created', @job.business.name + ' created a job', { category: "Jobs", type: "created" }
        end
      end

      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      if params[:job][:status]
        @job.business.users.each do |user|
          puts user.name, user.notification_subscription
          send_notification user, "Job status updated to #{@job.status}", "Job #{@job.title} status updated to #{@job.status}", { category: "Jobs", type: "status" }
        end
      end

      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully destroyed.'
  end

  private

  def index_eager_load
    if current_user.booker?
      @jobs = @jobs.includes(:tradesmen_profile)
    elsif current_user.tradesmen?
      @jobs = @jobs.includes(:business)
    else
      @jobs = @jobs.includes(:business, :tradesmen_profile)
    end
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:title, :description, :address, :business_id, :tradesmen_profile_id, :status, :status_been_started, :status_been_completed, :active, :quote_required)
  end
end
