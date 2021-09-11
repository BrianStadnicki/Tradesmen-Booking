class JobsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /jobs
  def index
    index_paginate
    index_eager_load
    index_render
  end

  # GET /jobs/mine
  def mine
    index_paginate
    index_eager_load
    index_render
  end

  # GET /jobs/mine_active
  def mine_active
    index_eager_load
  end

  # GET /jobs/applicable
  def applicable
    index_eager_load
  end

  # GET /jobs/completed
  def completed
    index_paginate
    index_eager_load
    index_render
  end

  # GET /jobs/1
  def show
    @job_tradesmen_application = current_user.tradesmen_profile_belongs.job_tradesmen_application(@job) if current_user.tradesmen?
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
    @job.status = "Awaiting applications" if !@job.status
    @job.status_been_started |= false
    @job.status_been_completed |= false
    @job.address_house_street = @job.address_house_street.titleize
    @job.address_city_town = @job.address_city_town.titleize
    @job.address_province_state = @job.address_province_state.titleize
    @job.address_post_code = @job.address_post_code.upcase
    @job.business_id = @current_user.business_belongs.id unless @current_user.admin?
    @job.posted = Date.today

    if @job.save!

      @job.business.tradesmen.includes(:users).each do |tradesmen|
        tradesmen.users.each do |user|
          send_notification user, 'Job created', @job.business.name + ' created a job', "Jobs", "created"
        end
      end

      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /jobs/1
  def update

    if params[:job][:status_been_completed] == "true"
      @job.completed = Date.today
    end

    if @job.update(job_params)
      if params[:job][:status]
        @job.business.users.each do |user|
          send_notification user, "Job status updated to #{@job.status}", "Job #{@job.title} status updated to #{@job.status}", "Jobs", "status"
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

  def index_paginate
    @jobs = @jobs.paginate(page: params[:page], per_page: 5)
  end

  def index_eager_load
    if current_user.booker?
      @jobs = @jobs.includes(:tradesmen_profile)
    elsif current_user.tradesmen?
      @jobs = @jobs.includes(:business)
    else
      @jobs = @jobs.includes(:business, :tradesmen_profile)
    end
  end

  def index_render
    render layout: false if params[:page]
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:title, :description, :address_house_street, :address_city_town, :address_province_state, :address_post_code, :business_id, :tradesmen_profile_id, :status, :status_been_started, :status_been_completed, :active, :quote_required)
  end
end
