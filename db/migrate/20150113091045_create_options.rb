class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string  :key
      t.string  :value
      t.string  :objectable_type
      t.integer :objectable_id

      t.timestamps
    end

    add_index :options, [:objectable_id, :objectable_type]
  end
end
