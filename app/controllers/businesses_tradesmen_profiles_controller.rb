class BusinessesTradesmenProfilesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # POST /businesses
  def create
    @business_tradesmen_profile = BusinessesTradesmenProfile.new(business_tradesmen_profile_params)
    if @business_tradesmen_profile.save
      redirect_back notice: 'Business<->Tradesmen was successfully created.', fallback_location: root_path
    else
      render :new
    end
  end

  # DELETE /businesses/1
  def destroy
    @business_tradesmen_profile.destroy
    redirect_back notice: 'Business<->Tradesmen was successfully destroyed.', fallback_location: root_path
  end

  private

  # Only allow a list of trusted parameters through.
  def business_tradesmen_profile_params
    params.permit(:business_id, :tradesmen_profile_id)
  end
end
