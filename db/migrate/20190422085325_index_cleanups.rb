class IndexCleanups < ActiveRecord::Migration[5.2]
  def change
    remove_index "quotations", name: "index_wares_on_quotation_id"
    remove_index "quotations", name: "index_services_on_quotation_id"
    remove_index "customers", name: "index_services_on_customer_id"
    remove_index "invoices", name: "index_services_on_invoice_id"
  end
end
