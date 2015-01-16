class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :old_id # ID клиента в ИБСО
      t.string :id_crm # ID клиента в CRM
      t.string :name
      t.string :inn
      t.string :kpp
      t.references :low_form, index:true

      t.timestamps
    end
  end
end
