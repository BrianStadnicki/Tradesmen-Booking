# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel, :inactive]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/inactive
  def inactive
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    params[:user][:email] = params[:user][:unconfirmed_email]
    if params[:user][:role_id].to_i != Role.user_category.find_by(name: 'Tradesman').id
      redirect_back fallback_location: ''
    else
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource), notice: 'Please check your email'
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
        end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    if params[:user][:role_id].present? and params[:user][:role_id].to_i != @user.role.id
      redirect_back fallback_location: ''
    else
      super
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if current_user.tradesmen? and !@current_user.tradesmen_profile_belongs.present?
      new_tradesmen_profile_path
    elsif current_user.booker? and !@current_user.business_belongs.present?
      new_business_path
    end
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    '/users/registrations/inactive'
  end

end
