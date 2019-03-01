json.extract! customer, :id, :name, :mail, :tva_record, :street, :number, :cp, :locality, :country, :created_at, :updated_at
json.url customer_url(customer, format: :json)
