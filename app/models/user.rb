class User < ApplicationRecord
  has_secure_password

  has_many :postagens, dependent: :destroy
  has_many :comentarios, through: :postagens

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, on: :create },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, if: -> { password.present? } }
end
