class CreateClientsSegments < ActiveRecord::Migration
  def change
    create_table :clients_segments do |t|
      t.references :client, index: true
      t.references :segment, index: true
      t.date :date

      t.timestamps
    end
  end
end
