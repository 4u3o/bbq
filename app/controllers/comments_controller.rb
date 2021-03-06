class CommentsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      emails =
        current_user.present? ?
          @event.visitors_emails - [@new_comment.user.email] :
          @event.visitors_emails

      emails.each do |mail|
        EventMailer.comment(@event, @new_comment, mail).deliver_now
      end

      redirect_to event_path(@event), notice: t('.success')
    else
      render 'events/show', alert: t('.error')
    end
  end

  def destroy
    message = { notice: t('.success') }

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = { alert: t('comments.create.error') }
    end

    redirect_to event_path(@event), message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end
end
