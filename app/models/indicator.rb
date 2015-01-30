class Indicator < ActiveRecord::Base
  belongs_to :sign_type,   class_name: 'Dictionary'
  belongs_to :data_type,   class_name: 'Dictionary'
  belongs_to :object_type, class_name: 'Dictionary'
  belongs_to :product,     class_name: 'Dictionary'
  belongs_to :accum_level, class_name: 'Dictionary'

  has_many :children_rules, class_name: 'IndicatorRule', foreign_key: 'parent_indicator_id'
  has_many :parent_rules,   class_name: 'IndicatorRule', foreign_key: 'child_indicator_id'

  has_many :children, through: :children_rules
  has_many :parents,  through: :parent_rules

  validates :name, presence: true, uniqueness: {scope: [:sh_name]}

  scope :roots, -> { joins(:parent_rules).where(parent_rules: {parent_indicator_id: nil}) }

  # Подсчет показателя по дереву
  def calculate(options)
    self.children_rules.on(options['on']).to_a.sum do |rule|
      if rule.ready?
        rule.calculate(options)
      else
        if rule.child
         rule.child.calculate(options)
        end
      end || 0
    end
  end
end
