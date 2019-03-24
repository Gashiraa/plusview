class AddTotalProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :total_gross, :float
    add_column :projects, :total, :float
  end
end
