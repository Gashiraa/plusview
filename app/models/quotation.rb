# frozen_string_literal: true

class Quotation < ApplicationRecord
  belongs_to :payment, optional: true
  belongs_to :customer, optional: true
  belongs_to :project, optional: true

  enum status: [:'Créé', :'Envoyé', :'Accepté']

  def update_quotation_content_on_destroy(quotation)
    quotation.wares.update(status: 'A facturer', invoice_id: nil)
    quotation.projects.update(status: 'Terminé', invoice_id: nil)
  end

  def update_totals_quotation(quotation)
    quotation.update(total: quotation.project ? quotation.project.total : 0,
                     total_gross: quotation.project ? quotation.project.total_gross : 0)
  end
end
