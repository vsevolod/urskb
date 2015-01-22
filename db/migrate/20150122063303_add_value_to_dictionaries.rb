class AddValueToDictionaries < ActiveRecord::Migration
  def change
    add_column :dictionaries, :value, :text
  end
end
