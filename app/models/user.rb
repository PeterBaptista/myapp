class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, format: { with: /\A[a-zA-Z0-9]+\z/, message: "must contain only letters and numbers" }
  validates :cpf, presence: true, uniqueness: true

  validate :cpf_must_be_valid

  private

  def cpf_must_be_valid
    errors.add(:cpf, 'is not valid') unless CPF.valid?(cpf)
  end
end
