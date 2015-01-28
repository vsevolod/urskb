class AddOptionsForIndicatorRules < ActiveRecord::Migration
  def change
    add_column 'indicator_rules', 'options', :text
    remove_column 'indicator_rules', 'old_text_condition', :text
  end
end
