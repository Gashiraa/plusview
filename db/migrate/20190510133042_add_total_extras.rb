class AddTotalExtras < ActiveRecord::Migration[5.2]
  def change
    add_column :extras, :total_gross, :float
    add_column :extras, :total, :float
    remove_column :extras, :display_name
  end
end
