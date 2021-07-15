class BusinessesTradesmenProfileController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource # FIXME: cancancan isn't loading and creating resources

  def index
  end

  # POST /businesess_tradesmen_profiles
  def create
    @business_tradesmen_profile = BusinessesTradesmenProfile.new(businesses_tradesmen_profile_params)
    if @business_tradesmen_profile.save
      redirect_back fallback_location: root_url, notice: 'Tradesmen profile was successfully created.'
    else
      render :new
    end
  end

  # DELETE /businesses_tradesmen_profiles/1
  def destroy
    if params[:id]
      @business_tradesmen_profile = BusinessesTradesmenProfile.find(params[:id])
    else
      @business_tradesmen_profile = BusinessesTradesmenProfile.find_by(
        tradesmen_profile_id: params[:tradesmen_profile_id], business_id: params[:business_id])
    end
    @business_tradesmen_profile.destroy
    redirect_back fallback_location: root_url, notice: 'Tradesmen profile was successfully destroyed.'
  end

  def businesses_tradesmen_profile_params
    params.permit(:tradesmen_profile_id, :business_id)
  end
end
