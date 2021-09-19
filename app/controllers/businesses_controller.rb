class BusinessesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /businesses
  def index
    @businesses = @businesses.paginate(page: params[:page], per_page: 30)
    render layout: false if params[:page]
  end

  # GET /businesses/trusted
  def trusted
    if @current_user.tradesmen?
      @businesses = @current_user.tradesmen_profile_belongs.businesses
    end
    @businesses = @businesses.paginate(page: params[:page], per_page: 30)
    render layout: false if params[:page]
  end

  # GET /businesses/1
  def show
    if @current_user.tradesmen?
      @business_tradesmen_profile =
        BusinessesTradesmenProfile.find_by(business_id: @business.id,
                                           tradesmen_profile_id: @current_user.tradesmen_profile_belongs.id)
    end
  end

  # GET /businesses/new
  def new
  end

  # GET /businesses/1/edit
  def edit
  end

  # POST /businesses
  def create
    ActiveRecord::Base.transaction do
      if current_user.admin?
        @business.owner = User.invite!(email: params[:business][:owner_id], role: Role.find_by(name: "Booker", category: RoleCategory.find_by(name: "User")))
      else
        @business.owner_id = @current_user.id
      end
      @business.save!

      unless current_user.admin?
        @business_user = BusinessUser.new(user: @business.owner, business: @business,
                                          role: Role.find_by(name: 'Admin',
                                                             category: RoleCategory.find_by(name: 'Business')))
        @business_user.business_id = @business.id
        @business_user.save!
      end
      redirect_to @business, notice: 'Business was successfully created.'

    rescue
      render :new
      raise ActiveRecord::Rollback

    end
  end

  # PATCH/PUT /businesses/1
  def update
    if @business.update(business_params)
      # Don't know why this hack is needed, hopefully temporary
      @business.owner_id = params['owner']['owner_id'] if params['owner']
      @business.save!

      @business.users.each do |user|
        send_notification user, "Your business profile was updated", "", "Business", "updated"
      end

      redirect_to @business, notice: 'Business was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /businesses/1
  def destroy
    @business.destroy
    redirect_to businesses_url, notice: 'Business was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def business_params
    params.require(:business).permit(:name, :description, :address, :owner_id, :phone, :phone2, :email)
  end
end
