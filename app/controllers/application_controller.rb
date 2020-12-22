class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?

  def current_user_can_edit?(model)
    # TODO: &.
    user_signed_in? && (
      model.user == current_user ||
        (model.try(:event).present? && model.event.user == current_user)
    )
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:email, :name, :password, :password_confirmation]
    )
  end

  def notify_subscribers(event, update)
    all_emails =
      (event.subscriptions.map(&:user_email) + [event.user.email] - [update.user.email]).uniq

    all_emails.each do |mail|
      EventMailer.comment(event, update, mail).deliver_now
    end
  end
end
