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

  # Отдаем дерево польностью.
  # TODO Можно доделать возможность отдавать только по конкретному условию.
  def self.tree(options = {})
    options[:date] ||= Date.today
    # Array: [id, name, parent_indicator_id]
    records = self.connection.select_rows((<<-SQL).gsub(':date', options[:date].to_date.to_s))
      select indicators.id, indicators.name, indicator_rules.parent_indicator_id
      from indicators
      full outer join indicator_rules on indicator_rules.child_indicator_id = indicators.id
      where indicators.id IS NOT NULL
      AND   indicator_rules.id IS NOT NULL
      AND (indicator_rules.start_date IS NULL OR indicator_rules.start_date <= ':date')
      AND (indicator_rules.end_date IS NULL OR indicator_rules.end_date >= ':date')
    SQL
    self.get_children(records)
  end

  private

    def self.get_children(records, parent_id = nil)
      # Array: [id, name, parent_indicator_id]
      records.find_all{|r| r[2] == parent_id}.map do |child|
        hash = {
          label: child[1],
          uid: child[0],
          children: []
        }
        if (_children = self.get_children(records, child[0])).size > 0
          hash[:children] = _children
        end
        hash
      end
    end
end
