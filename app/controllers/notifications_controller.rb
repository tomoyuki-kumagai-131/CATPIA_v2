class NotificationsController < ApplicationController
  before_action :logged_in_user

  def index
    @notifications = current_user.notifications
    current_user.update_attribute(:notification, false)
  end
end
