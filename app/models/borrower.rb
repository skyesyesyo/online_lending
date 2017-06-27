class Borrower < ActiveRecord::Base
  has_secure_password

  has_many :historys
  has_many :lenders_history, through: :historys, source: :lender

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :money, :purpose, :description, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, on: :create
  before_save :email_lowercase

  def email_lowercase
      email.downcase!
  end
end
