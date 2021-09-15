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
  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    yield resource if block_given?

    if invitation_accepted

      if resource.booker?
        if resource.business.present?
          BusinessUser.create!(user: resource, business: resource.business, role: Role.find_by(name: 'Owner', category: RoleCategory.find_by(name: 'Business')))
        end
      elsif resource.tradesmen?
        if resource.tradesmen_profile.present?
          TradesmenProfileUser.create!(user: resource, tradesmen_profile: resource.tradesmen_profile, role: Role.find_by(name: 'Owner', category: RoleCategory.find_by(name: 'Tradesmen Profile')))
        end
      end

      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        sign_in(resource_name, resource)
        respond_with resource, location: after_accept_path_for(resource)
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource) { render :edit }
    end
  end

  # GET /resource/invitation/remove?invitation_token=abcdef
  # def destroy
  # end

  protected

  def invite_params
    devise_parameter_sanitizer.permit(:invite, keys: [:name, :email, :phone, :role_id, :business_id, :tradesmen_profile_id])
  end

  # def update_resource_params
  #   devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :phone])
  # end

end
