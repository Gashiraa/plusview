class Project < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :quotation, optional: true
  belongs_to :customer, optional: true
  has_many :wares
  has_many :services

  enum status: [:'En devis', :'A traiter', :'Facturé']
  enum wielding: [:'1', :'2', :'3', '4', '5'], _suffix: true
  enum machining: [:'1', :'2', :'3', '4', '5'], _suffix: true
  enum karcher: [:'1', :'2', :'3', '4', '5'], _suffix: true

end