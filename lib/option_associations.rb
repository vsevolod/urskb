module OptionAssociations

  def self.included(base)
    base.class_eval do
      has_many :options, as: :objectable
    end
    base.extend OptionAssociations::ClassMethods
  end

  module ClassMethods

    def add_option(key)
      self.redefine_method key do
        options[key]
      end

      self.redefine_method "#{key}=" do |new_value|
        options[key]=new_value
      end

      self.redefine_method "#{key}+=" do |additional_value|
        options.push(key, additional_value)
      end

      self.redefine_method "add_to_#{key}=" do |additional_value|
        options.create(key: key, value: additional_value)
      end
    end

  end

end
