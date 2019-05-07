class Customer < ApplicationRecord
  has_many :invoices
  has_many :projects

  def listmodel
    projects.where('status = 0')
  end

  def listmodel_invoice
    if true
      projects.where('"projects".status = 2 or "projects".invoice_id=' + 190016.to_s)
    else
      projects.where('status = 2')
    end
  end

end