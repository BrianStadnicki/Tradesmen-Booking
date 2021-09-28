class TradesmenProfilesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /tradesmen_profiles
  def index
    @tradesmen_profiles = @tradesmen_profiles.includes(:tradesmen_trades).paginate(page: params[:page], per_page: 30)
    render layout: false if params[:page]
  end

  # Get /tradesmen_profiles/trusted
  def trusted
    if @current_user.booker?
      @tradesmen = @current_user.business_belongs.tradesmen
    end
    @tradesmen = @tradesmen.includes(:tradesmen_trades).paginate(page: params[:page], per_page: 30)
    render layout: false if params[:page]
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
    ActiveRecord::Base.transaction do

      if current_user.admin?
        @tradesmen_profile.owner = User.invite!(email: params[:tradesmen_profile][:owner_id], role: Role.find_by(name: "Tradesman", category: RoleCategory.find_by(name: "User")), tradesmen_profile: @tradesmen_profile)
      else
        @tradesmen_profile.owner_id = current_user.id
      end

      params[:tradesmen_profile][:tradesmen_trade_ids].each do |tradesmen_trade_id|
        unless tradesmen_trade_id.empty?
          tradesmen_trade = TradesmenTrade.find(tradesmen_trade_id)
          @tradesmen_profile.tradesmen_trades << tradesmen_trade
        end
      end

      @tradesmen_profile.save

      unless current_user.admin?
        @tradesmen_profile_user = TradesmenProfileUser.new(user: @tradesmen_profile.owner,
                                                           tradesmen_profile: @tradesmen_profile,
                                                           role: Role.find_by(name: 'Admin',
                                                                              category: RoleCategory.find_by(name: 'Tradesmen Profile')))
        @tradesmen_profile_user.save
      end

      redirect_to @tradesmen_profile, notice: 'Tradesmen profile was successfully created.'
    rescue
      render :new
      raise ActiveRecord::Rollback
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

      @tradesmen_profile.users.each do |user|
        send_notification user, "Your tradesmen profile was updated", "Please ensure this is correct", "TradesmenProfile", "updated"
      end

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
      params.require(:tradesmen_profile).permit(:name, :description, :tradesmen_trade_ids, :owner_id, :phone, :phone2, :email)
    end
end
