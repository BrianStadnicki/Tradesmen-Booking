class Users::InvitationsController < Devise::InvitationsController

  # GET /resource/invitation/new
  # def new
  # end

  # POST /resource/invitation
  def create
    if current_user.booker?
      @invited_user = User.invite!({email: params['user']['email'], role: Role.user_category.find_by(name: 'Booker'), name: params['user']['name'], phone: params['user']['phone']}, current_user)
      BusinessUser.create!(business: current_user.business_belongs, user: @invited_user, role: Role.find(params['user']['role_id']))
      redirect_to business_path(current_user.business_belongs)
    elsif current_user.tradesmen?
      @invited_user = User.invite!({email: params['user']['email'], role: Role.user_category.find_by(name: 'Tradesman'), name: params['user']['name'], phone: params['user']['phone']}, current_user)
      TradesmenProfileUser.create!(tradesmen_profile: current_user.tradesmen_profile_belongs, user: @invited_user, role: Role.find(params['user']['role_id']))
      redirect_to tradesmen_profile_path(current_user.tradesmen_profile_belongs)
    end
  end

  # GET /resource/invitation/accept?invitation_token=abcdef
  # def edit
  # end

  # PUT /resource/invitation
  # def update
  # end

  # GET /resource/invitation/remove?invitation_token=abcdef
  # def destroy
  # end

  protected

  def invite_params
    devise_parameter_sanitizer.permit(:invite, keys: [:name, :email, :phone, :role_id, :business_id, :tradesmen_profile_id])
  end

  # def update_resource_params
  #   devise_parameter_sanitizer.sanitize(:accept_invitation)
  # end
end
