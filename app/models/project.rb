# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :invoice, optional: true

  has_one :quotation, dependent: :nullify

  has_many :wares, dependent: :nullify
  has_many :services, dependent: :nullify

  has_many :project_extra_lines
  has_many :extra, through: :project_extra_lines

  enum status: [:Devis, :'En réalisation', :'Terminé', :'Facturé', :'Payé']

  def update_totals_project(project)
    project.update(total: total, total_gross: total_gross)
  end

  def total
    wares.collect { |w| w.valid? ? w.total_cost : 0 }.sum +
      services.collect { |s| s.valid? ? s.total_cost : 0 }.sum +
      project_extra_lines.collect { |s| s.valid? ? s.total : 0 }.sum

  end

  def total_gross
    wares.collect { |w| w.valid? ? w.total_gross : 0 }.sum +
      services.collect { |s| s.valid? ? s.total_gross : 0 }.sum +
      project_extra_lines.collect { |s| s.valid? ? s.total_gross : 0 }.sum
  end
end
