class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name
      t.string :number
      t.references :object_type, index: true
      t.string :ancestry
      t.string :state
      t.date :open_date
      t.date :close_date
      t.text :comment
      t.string :old_name
      t.string :old_number
      t.boolean :fl_ato
      t.string :old_id

      t.timestamps
    end
  end
end
