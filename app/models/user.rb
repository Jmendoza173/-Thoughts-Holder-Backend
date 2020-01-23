class User < ApplicationRecord
  has_many :notes

  has_secure_password

  validates_presence_of :username, :firstName, :lastName, :email
  validates_uniqueness_of :email, :username, :case_sensitive => false
end
