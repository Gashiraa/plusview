class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :mail
      t.integer :tva_record
      t.string :street
      t.integer :number
      t.integer :cp
      t.string :locality
      t.string :country

      t.timestamps
    end
  end
end
