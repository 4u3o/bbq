class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers,
           through: :subscriptions, source: :user
  has_many :photos, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true
  validates :datetime, presence: true, inclusion: { in: (Time.now..) }
  validates :user, presence: true
  validates :pincode, length: { is: 3 }, format: /\A\p{Digit}{3}\z/, if: -> { pincode.present? }

  def visitors
    (subscribers + [user]).uniq
  end

  def visitors_emails
    (subscriptions.map(&:user_email) + [user.email]).uniq
  end

  def pincode_valid?(pin2chek)
    pincode == pin2chek
  end
end
