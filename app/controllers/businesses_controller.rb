class BusinessesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /businesses
  def index
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
    @business.owner_id = @current_user.id unless @current_user.admin?
    if @business.save
      redirect_to @business, notice: 'Business was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /businesses/1
  def update
    if @business.update(business_params)
      # Don't know why this hack is needed, hopefully temporary
      @business.owner_id = params['owner']['owner_id']
      @business.save
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
    params.require(:business).permit(:name, :description, :address, :phone, :owner_id)
  end
end
