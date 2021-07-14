class BusinessesTradesmenProfilesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # POST /businesses_tradesmen_profiles
  def create
    if @business_tradesmen_profile.save
      redirect_back notice: 'Business<->Tradesmen was successfully created.', fallback_location: root_path
    else
      render :new
    end
  end

  # DELETE /businesses_tradesmen_profiles/1
  def destroy
    @business_tradesmen_profile.destroy
    redirect_back notice: 'Business<->Tradesmen was successfully destroyed.', fallback_location: root_path
  end

  private

  # Only allow a list of trusted parameters through.
  def businesses_tradesmen_profile_params
    params.permit(:business_id, :tradesmen_profile_id)
  end
end
