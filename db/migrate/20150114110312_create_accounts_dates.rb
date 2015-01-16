class CreateAccountsDates < ActiveRecord::Migration
  def change
    create_table :accounts_dates do |t|
      t.references :account, index: true
      t.text :options
      t.float :balance
      t.float :currency_balance
      t.references :division, index: true

      t.timestamps
    end
  end
end
