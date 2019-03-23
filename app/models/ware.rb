class Ware < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :invoice, optional: true
  belongs_to :customer, optional: true
  belongs_to :quotation, optional: true
  enum status: [:'Encodé',:'Atelier', :'Attribué', :'A facturer', :'Facturé', :'Payé']
end