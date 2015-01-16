class AddOptionsForClients < ActiveRecord::Migration
  def change
    add_column :clients, :options, :text
  end
end
