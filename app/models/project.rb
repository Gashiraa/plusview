# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :quotation, optional: true
  belongs_to :customer, optional: true
  has_many :wares, dependent: :nullify
  has_many :services, dependent: :nullify

  enum status: [:Devis, :'En réalisation', :'Terminé', :'Facturé', :'Payé']
  enum wielding: [:'1', :'2', :'3', '4', '5'], _suffix: true
  enum machining: [:'1', :'2', :'3', '4', '5'], _suffix: true
  enum karcher: [:'1', :'2', :'3', '4', '5'], _suffix: true


  def update_totals(project)
    project.update(total: total, total_gross: total_gross)
  end

  def total
    wares.collect {|w| w.valid? ? w.total_cost : 0}.sum +
        services.collect {|s| s.valid? ? s.total_cost : 0}.sum
  end

  def total_gross
    wares.collect {|w| w.valid? ? w.total_gross : 0}.sum +
        services.collect {|s| s.valid? ? s.total_gross : 0}.sum
  end
end
