class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }
  # Добавил валидацию для того, чтобы simple_form подхватил required
  validates :email, presence: true, length: { maximum: 255 }
end
