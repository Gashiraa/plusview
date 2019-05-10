class TotalsMoveToLines < ActiveRecord::Migration[5.2]
  def change
    add_column :project_extra_lines, :total_gross, :float
    add_column :project_extra_lines, :total, :float
    remove_column :extras, :total_gross, :float
    remove_column :extras, :total, :float
  end
end