class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :post, :created_at, :updated_at

  belongs_to :user
end
