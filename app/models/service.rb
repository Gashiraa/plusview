class Service < ApplicationRecord

  include TranslateEnum

  belongs_to :project, optional: true
  belongs_to :invoice, optional: true
  belongs_to :customer, optional: true
  belongs_to :quotation, optional: true

  enum status: [:assigned, :invoiced, :paid]
  translate_enum :status

end