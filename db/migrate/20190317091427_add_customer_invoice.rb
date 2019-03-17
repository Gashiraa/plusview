class AddCustomerInvoice < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :customer, index: true
  end
end
