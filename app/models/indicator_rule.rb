class IndicatorRule < ActiveRecord::Base
  belongs_to :child,  foreign_key: 'child_indicator_id',  class_name: 'Indicator'
  belongs_to :parent, foreign_key: 'parent_indicator_id', class_name: 'Indicator'

  #validates :parent_indicator_id, uniqueness: {scope: [:child_indicator_id]}

  def active?(date = Date.today)
    self.start_date >= date && (!self.end_date || self.end_date < date)
  end

end
