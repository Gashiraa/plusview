class AddCustomerRefPayment < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :customer, index: true
    add_foreign_key :payments, :customers
  end
end
