class AddPaymentReference < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :reference, :string
  end
end
