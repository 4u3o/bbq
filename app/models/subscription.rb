class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email,
            presence: true,
            format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/,
            unless: -> { user.present? }
  validates :user,
            uniqueness: {scope: :event_id},
            if: -> { user.present? }
  validates :user_email,
            uniqueness: {scope: :event_id},
            unless: -> { user.present? }
  validate :cannot_self_subscribe, :cannot_subscribe_with_presented_email

  def user_name
    return user.name if user.present?
    super
  end

  def user_email
    return user.email if user.present?
    super
  end

  def cannot_self_subscribe
    errors.add(:user_email, :self_subscribe) if event.user.email == user_email
  end

  def cannot_subscribe_with_presented_email
    unless user.present?
      errors.add(:user_email, :email_already_exist) if
        User.exists?(email: user_email)
    end
  end
end
