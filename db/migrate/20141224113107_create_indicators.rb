class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :sh_name
      t.references :sign_type, index: true
      t.text :comment
      t.references :date_type, index: true
      t.references :object_type, index: true
      t.references :product, index: true
      t.references :accum_level, index: true
      t.string :old_id

      t.timestamps
    end
  end
end
