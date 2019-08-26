json.extract! company, :id, :name, :street, :postcode, :locality, :phone, :email, :created_at, :updated_at
json.url company_url(company, format: :json)
