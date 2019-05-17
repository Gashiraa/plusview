class AddTotalPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :total, :float
  end
end
