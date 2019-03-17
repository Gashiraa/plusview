class Invoice < ApplicationRecord
  belongs_to :payment, optional: true
  belongs_to :customer
  has_many :projects
  has_many :wares
end
