class BusinessesTradesmenProfilesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /businesses_tradesmen_profiles
  def index
  end

  # GET /businesses_tradesmen_profiles/1
  def show
  end

  # GET /businesses_tradesmen_profiles/new
  def new
  end

  # GET /businesses_tradesmen_profiles/1/edit
  def edit
  end

  # POST /businesses_tradesmen_profiles
  def create
    if @businesses_tradesmen_profile.save
      redirect_to @businesses_tradesmen_profile, notice: 'Businesses tradesmen profile was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /businesses_tradesmen_profiles/1
  def update
    if @businesses_tradesmen_profile.update(businesses_tradesmen_profile_params)
      redirect_to @businesses_tradesmen_profile, notice: 'Businesses tradesmen profile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /businesses_tradesmen_profiles/1
  def destroy
    @businesses_tradesmen_profile.destroy
    redirect_to businesses_tradesmen_profiles_url, notice: 'Businesses tradesmen profile was successfully destroyed.'
  end

  private

    # Only allow a list of trusted parameters through.
    def businesses_tradesmen_profile_params
      params.require(:businesses_tradesmen_profile).permit(:business_id, :tradesmen_profile_id)
    end
end
