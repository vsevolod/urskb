class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :old_id
      t.string :number
      t.date :start_date
      t.date :end_date
      t.string :collection, index: true

      t.references :name, index: true
      t.references :agreement, index: true

      t.timestamps
    end
    add_index :accounts, :number
  end
end
