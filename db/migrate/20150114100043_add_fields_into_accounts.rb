class AddFieldsIntoAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.string :account_type, index: true
      t.string :state
      t.references :currency, index: true
      t.references :owner, index: true
      t.references :account_client, index: true
      t.string :class_id
      t.text :options
    end
  end
end
