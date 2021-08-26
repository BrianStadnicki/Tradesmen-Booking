class JobsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /jobs
  def index
    @jobs = @jobs.includes(:business)
  end

  # GET /jobs/mine
  def mine
    @jobs = @jobs.includes(:business)
  end

  # GET /jobs/mine_active
  def mine_active
    @jobs = @jobs.includes(:business)
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
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
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

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:title, :description, :address, :business_id, :tradesmen_profile_id, :status, :status_been_started, :status_been_completed, :active, :quote_required)
  end
end
