class NotificationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /notifications
  def index
    @notifications = current_user.notifications.paginate(page: params[:page], per_page: 10).order(datetime: :desc)
    render layout: false
  end

  # GET /notifications/1
  def show
    render layout: false
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
    else
      render :edit
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def notification_params
    params.require(:notification).permit(:read)
  end
end
