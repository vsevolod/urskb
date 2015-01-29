class ModifyColumns < ActiveRecord::Migration
  def self.up
    add_column :accounts, :xml_options, :xml
    add_column :accounts_dates, :xml_options, :xml
    add_column :agreements, :xml_options, :xml
    add_column :clients, :xml_options, :xml
  end

  def self.down
    remove_column :accounts, :xml_options
    remove_column :accounts_dates, :xml_options
    remove_column :agreements, :xml_options
    remove_column :clients, :xml_options
  end
end
