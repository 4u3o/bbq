class SubscriptionsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_subscription, only: %i[destroy]

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save
      EventMailer.subscription(@event, @new_subscription).deliver_now
      redirect_to event_path(@event), notice: t('.success')
    else
      render 'events/show', alert: t('.error')
    end
  end

  def destroy
    message = { notice: t('.success') }
    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = { alert: t('.create.error') }
    end

    redirect_to event_path(@event), message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
