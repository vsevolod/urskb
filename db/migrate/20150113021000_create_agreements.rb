class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.string :old_id
      t.string :updog # Служебное для установки рута
      t.string :type, index: true
      t.string :state
      t.string :number
      t.text   :options
      t.date   :start_date
      t.date   :end_date_plan
      t.date   :end_date_fact
      t.string :ancestry
      t.float  :sum

      t.references :client,   index: true
      t.references :division, index: true
      t.references :currency, index: true

      t.timestamps
    end
  end
end
