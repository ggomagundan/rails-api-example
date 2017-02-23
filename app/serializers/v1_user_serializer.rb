class V1UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :phone
  has_many :posts
end
