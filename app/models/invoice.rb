# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :payment, optional: true
  belongs_to :customer, optional: true
  has_many :projects
  has_many :wares

  enum status: %I[Emise Envoy\u00E9e Pay\u00E9e]

  def update_totals_invoice(invoice, projects, wares)
    invoice.update(total: do_total(projects, wares))
    invoice.update(total_gross: do_total_gross(projects, wares))
  end

  def do_total(projects, wares)
    wares.collect {|w| w.valid? ? w.total_cost : 0}.sum +
        projects.collect {|p| p.valid? ? p.total : 0}.sum
  end

  def do_total_gross(projects, wares)
    wares.collect {|w| w.valid? ? w.total_gross : 0}.sum +
        projects.collect {|p| p.valid? ? p.total_gross : 0}.sum
  end
end
