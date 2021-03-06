class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /users
  def index
    @users = @users.paginate(page: params[:page], per_page: 30)
    @users = @users.includes(:role, :tradesmen_profile_belongs, :business_belongs, business_user: [:role], tradesmen_profile_user: [:role])
    render layout: false if params[:page]
  end

  # GET /users/1
  def show
    @joined_on = @user.created_at.to_formatted_s(:short)

    @last_login = if @user.current_sign_in_at
                    @user.current_sign_in_at.to_formatted_s(:short)
    else
      'never'
                  end
  end

  # GET /users/new
  def new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  # GET /users/current_id
  def current_id
    render json: "{\"id\": #{current_user.id}}"
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :notification_subscription)
  end
end
