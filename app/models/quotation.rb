# frozen_string_literal: true

class Quotation < ApplicationRecord

  include TranslateEnum

  belongs_to :payment, optional: true
  belongs_to :customer, optional: true
  belongs_to :project, optional: true

  enum status: [:created, :accepted]
  translate_enum :status

  def update_totals_quotation(quotation)
    quotation.update(total: quotation.project ? quotation.project.total : 0,
                     total_gross: quotation.project ? quotation.project.total_gross : 0)
  end
end