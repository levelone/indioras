class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_secure_password

  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  PASSWORD_FORMAT = /\A
    (?=.*\d)    # Must contain a digit
    (?=.*[a-z]) # Must contain a lower case character
    (?=.*[A-Z]) # Must contain an upper case character
  /x

  validates_confirmation_of :password

  validates :name,
    presence: true,
    length: 4..16

  validates :email,
    presence: true,
    format: { with: EMAIL_FORMAT },
    uniqueness: { case_sensitive: false }

  validates :password, 
    presence: true, 
    length: { minimum: 8 },
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :create 

  validates :password, 
    allow_nil: true, 
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :update
end
