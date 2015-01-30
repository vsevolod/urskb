class ChangeTextConditionForIndicatorRules < ActiveRecord::Migration
  def change
    remove_column 'indicator_rules', 'text_condition'
    add_column 'indicator_rules', 'ready', 'boolean'
  end
end
