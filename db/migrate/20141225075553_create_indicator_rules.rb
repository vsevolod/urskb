class CreateIndicatorRules < ActiveRecord::Migration
  def change
    create_table :indicator_rules do |t| # PokRules
      t.integer :level                   # TypeRule
      t.references :parent_indicator, index: true # IDMainPok
      t.references :child_indicator, index: true  # IDSubPok
     #t.string :operation                # IDOper
     #t.string :sql_condition            # Uslov
     #t.string :unit                     # EdIzm
      t.date :start_date                 # sDate
      t.date :end_date                   # eDate
      t.string :old_id

      t.timestamps
    end
  end
end
