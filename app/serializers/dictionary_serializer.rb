class DictionarySerializer < ActiveModel::Serializer
  attributes :id, :name, :tag, :value, :parent_id

  # has_many :...

  # url [:...]

end
