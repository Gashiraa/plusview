class AddTotalGrossInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :total_gross, :float
  end
end
