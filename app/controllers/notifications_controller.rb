class NotificationsController < ApplicationController
  def update
    @notificaton = Notification.find_by id: params[:id]
    @notificaton.update_attributes checked: true
    redirect_to Post.find_by id: @notificaton.notificationable_id
  end
end
