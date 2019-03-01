json.extract! invoice, :id, :payment_id, :date, :status, :total, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
