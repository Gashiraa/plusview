class Project < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :quotation, optional: true
  belongs_to :customer
  enum status: [:'En devis', :'A traiter', :'Facturé']
end