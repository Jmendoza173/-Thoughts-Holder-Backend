class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :firstName, :lastName, :email

  has_many :notes
end
