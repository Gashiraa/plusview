class AddTvaExtra < ActiveRecord::Migration[5.2]
  def change
    add_column :extras, :tva_rate, :float
  end
end
