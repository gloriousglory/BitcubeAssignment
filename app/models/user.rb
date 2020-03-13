class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  # 1. Email must be unique
  # 2. Supply at least a first name and last name
  # 3. Password must be at least 6 characters long, have at least 1 number, 
  #    1 lowercase letter, 1 uppercase letter and 1 special character
  VALID_PASSWORD_REGEX = /\A(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9])/x
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :password, format: { with: VALID_PASSWORD_REGEX, 
    message: "Password must be at least 6 characters long, have at least 1 number, 
             1 lowercase letter, 1 uppercase letter and 1 special character" }

  # Get the id, email, first name and last name for Users except for the current user
  # Parameters:
  # current_user: don't get this user
  # Returns:
  # an array of Users with id, email, first name and last name fields
  def self.get_users_other_than(current_user_id)
    User.where.not(id: current_user_id).select(:id, :first_name, :last_name, :email).sort
  end
end
