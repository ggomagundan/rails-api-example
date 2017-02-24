class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :gender_str, :phone

  def gender_str
    return "male" if object.gender == 1
    return "female" if object.gender == 2
  end


  has_many :posts,  serializer: PostSerializer
end
