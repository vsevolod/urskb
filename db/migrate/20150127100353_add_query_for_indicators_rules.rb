class AddQueryForIndicatorsRules < ActiveRecord::Migration
  def change
    add_column :indicator_rules, :old_text_condition, :text
    add_column :indicator_rules, :text_condition, :text
  end
end
