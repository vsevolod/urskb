class IndicatorSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_one :object_type
  has_one :product

  #has_many :parent_rules
  #has_many :children_rules

end
