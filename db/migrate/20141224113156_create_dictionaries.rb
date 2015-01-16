class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.string :name
      t.string :tag
      t.string :ancestry
      t.string :old_name
      t.string :old_id

      t.timestamps
    end

    add_index :dictionaries, :ancestry
  end
end
