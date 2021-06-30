class TradesmenProfilesController < ApplicationController
  before_action :set_tradesmen_profile, only: [:show, :edit, :update, :destroy]

  # GET /tradesmen_profiles
  def index
    @tradesmen_profiles = TradesmenProfile.all
  end

  # GET /tradesmen_profiles/1
  def show
  end

  # GET /tradesmen_profiles/new
  def new
    @tradesmen_profile = TradesmenProfile.new
  end

  # GET /tradesmen_profiles/1/edit
  def edit
  end

  # POST /tradesmen_profiles
  def create
    @tradesmen_profile = TradesmenProfile.new(tradesmen_profile_params)

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
    # Use callbacks to share common setup or constraints between actions.
    def set_tradesmen_profile
      @tradesmen_profile = TradesmenProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tradesmen_profile_params
      params.require(:tradesmen_profile).permit(:name, :description, :tradesmen_trade_ids, :owner_id)
    end
end
