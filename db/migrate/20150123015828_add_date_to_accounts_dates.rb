class AddDateToAccountsDates < ActiveRecord::Migration
  def change
    add_column :accounts_dates, 'date', :date
  end
end
