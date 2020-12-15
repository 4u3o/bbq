class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email,
            presence: true,
            format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/,
            unless: -> { user.present? }
  validates :user,
            uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email,
            uniqueness: {scope: :event_id}, unless: -> { user.present? }

  def user_name
    return user.name if user.present?
    super
  end

  def user_email
    return user.email if user.present?
    super
  end
end
