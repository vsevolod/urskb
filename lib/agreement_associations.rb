module AgreementAssociations

  def self.included(base)
    base.class_eval do
      #has_many :options, as: :objectable
    end
    base.extend AgreementAssociations::ClassMethods
  end

  module ClassMethods

    def belongs_to_store(name, model = Dictionary)
      define_method name do
        Dictionary.find_by_id(self.send("#{name}_id"))
      end
    end

  end

end
