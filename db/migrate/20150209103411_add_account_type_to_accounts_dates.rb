class AddAccountTypeToAccountsDates < ActiveRecord::Migration
  def self.up
    add_column :accounts_dates, :account_type, :string
  end

  def self.down
    remove_column :accounts_dates, :account_type
  end
end
