class AddNumInvoiceAndServicesFlag < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :display_number, :integer
    add_column :invoices, :services_details_flag, :boolean
  end
end
