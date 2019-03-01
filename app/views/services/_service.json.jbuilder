json.extract! service, :id, :project_id, :invoice_id, :customer_id, :quotation_id, :name, :comment, :hourly_rate, :coefficient, :date, :duration, :status, :tva_rate, :total_cost, :created_at, :updated_at
json.url service_url(service, format: :json)
