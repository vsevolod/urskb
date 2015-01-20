class DictionarySerializer < ActiveModel::Serializer
  attributes :id, :name, :tag, :parent_id

  # has_many :...

  # url [:...]

end
