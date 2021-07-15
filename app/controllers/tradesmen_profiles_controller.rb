class TradesmenProfilesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /tradesmen_profiles
  def index
  end

  # GET /tradesmen_profiles/1
  def show
    if @current_user.booker?
      @business_tradesmen_profile = BusinessesTradesmenProfile.find_by(business_id: @current_user.business_belongs.id,
                                                                      tradesmen_profile_id: @tradesmen_profile.id)
    end
  end

  # GET /tradesmen_profiles/new
  def new
  end

  # GET /tradesmen_profiles/1/edit
  def edit
  end

  # POST /tradesmen_profiles
  def create
    params[:tradesmen_profile][:tradesmen_trade_ids].each do |tradesmen_trade_id|
      unless tradesmen_trade_id.empty?
        tradesmen_trade = TradesmenTrade.find(tradesmen_trade_id)
        @tradesmen_profile.tradesmen_trades << tradesmen_trade
      end
    end

    if @tradesmen_profile.save
      redirect_to @tradesmen_profile, notice: 'Tradesmen profile was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tradesmen_profiles/1
  def update
    @tradesmen_profile.tradesmen_trades = []
    params[:tradesmen_profile][:tradesmen_trade_ids].each do |tradesmen_trade_id|
      unless tradesmen_trade_id.empty?
        tradesmen_trade = TradesmenTrade.find(tradesmen_trade_id)
        @tradesmen_profile.tradesmen_trades << tradesmen_trade
      end
    end

    if @tradesmen_profile.update(tradesmen_profile_params)
      redirect_to @tradesmen_profile, notice: 'Tradesmen profile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tradesmen_profiles/1
  def destroy
    @tradesmen_profile.destroy
    redirect_to tradesmen_profiles_url, notice: 'Tradesmen profile was successfully destroyed.'
  end

  private

    # Only allow a list of trusted parameters through.
    def tradesmen_profile_params
      params.require(:tradesmen_profile).permit(:name, :description, :tradesmen_trade_ids, :owner_id)
    end
end
