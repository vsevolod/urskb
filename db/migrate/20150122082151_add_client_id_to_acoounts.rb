class AddClientIdToAcoounts < ActiveRecord::Migration
  def change
    add_column :accounts, :client_id, :integer
    add_index :accounts, [:client_id]
  end
end
