class RenameAccountFieldsForAccountsDates < ActiveRecord::Migration
  def change
    rename_column :accounts_dates, :account_id, :recordable_id
    rename_column :accounts_dates, :account_type, :recordable_type
    rename_table  :accounts_dates, :records_dates
  end
end
