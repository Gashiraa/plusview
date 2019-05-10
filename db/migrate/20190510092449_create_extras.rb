class CreateExtras < ActiveRecord::Migration[5.2]
  def change
    create_table :extras do |t|
      t.string :display_name
      t.string :name
      t.string :unit
      t.string :unit_price

      t.timestamps
    end
  end
end
