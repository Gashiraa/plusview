class Project < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :quotation, optional: true
  belongs_to :customer, optional: true
end
