class Invoice < ApplicationRecord
  belongs_to :payment, optional: true
  belongs_to :customer, optional: true
  has_many :projects
  has_many :wares

  enum status: [:Emise, :'Envoyée', :'Payée']

end
