class AddGrossService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :total_gross, :float
  end
end
