class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :content 

  belongs_to :user
end
