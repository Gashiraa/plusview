class AddCustomerQuotation < ActiveRecord::Migration[5.2]
  def change
    add_reference :quotations, :customer, index: true
    add_foreign_key :quotations, :customers
  end
end
