class Option < ActiveRecord::Base
  belongs_to :objectable, polymorphic: true

  validates :value, uniqueness: {scope: [:key, :objectable_id, :objectable_type]}

  def self.get(key)
    where(key: key)
  end

  def self.push(key, value)
    where(key: key, value: value).first_or_create
  end

  def self.[](key)
    get(key).map(&:value)
  end

  def self.[]=(key, value)
    get(key).destroy_all
    push(key, value)
  end

end
