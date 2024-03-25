require 'digest'

class User < ApplicationRecord
  has_many :blogs

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates_confirmation_of :password

  before_save :encrypt_password

  def authenticate(password)
    self.password == encrypt(password)
  end

  private

  def encrypt_password
    self.password = encrypt(password)
  end

  def encrypt(password)
    # You can use any secure hashing algorithm here, for example, SHA-256
    Digest::SHA256.hexdigest(password)
  end
end
