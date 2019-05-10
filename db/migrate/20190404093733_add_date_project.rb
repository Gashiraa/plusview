class AddDateProject < ActiveRecord::Migration[5.2]
  def change
  add_column :projects, :date, :date
  end
end
