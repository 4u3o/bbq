class EventMailer < ApplicationMailer
  #   en.event_mailer.subscription.subject
  #
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: t('.subject', event: event.title)
  end

  #   en.event_mailer.comment.subject
  #
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: t('.subject', event: event.title)
  end
end
