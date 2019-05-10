class AddTotalsinvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :total_gross, :float
  end
end
