class PhotosController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_photo, only: %i[destroy]

  def create
    @new_photo = @event.photos.build(photo_params)

    @new_photo.user = current_user

    if @new_photo.save
      emails = @event.visitors_emails - [@new_photo.user.email]

      emails.each do |mail|
        EventMailer.photo(@event, @new_photo, mail).deliver_now
      end

      redirect_to event_path(@event), notice: t('.success')
    else
      render 'events/show', alert: I18n.t('error')
    end
  end

  def destroy
    message = { notice: t('.success') }

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = { alert: t('.create.error') }
    end

    redirect_to event_path(@event), message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end
end
