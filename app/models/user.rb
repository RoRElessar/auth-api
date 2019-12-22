class User < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_NAMES = /\A[a-zA-Z0-9]*\z/.freeze

  validates :name, :email, :password, :password_confirmation, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :name, format: { with: VALID_NAMES }
  validate :password_match_validation

  protected

  def password_match_validation
    return unless password != password_confirmation

    errors.add(:password, 'Password and password confirmation should match')
    errors.add(:password_confirmation, 'Password and password confirmation should match')
    throw :abort
  end
end
