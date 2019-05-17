class Payment < ApplicationRecord

  has_many :invoices, dependent: :nullify
  belongs_to :customer, optional: true

  def update_total(payment, invoices)
    payment.update(total: do_total(invoices))
  end

  def update_statuses(payment)
    payment.invoices.each do |invoice|
      invoice.update(status: :paid)
      invoice.projects.each do |project|
        project.wares.update(status: :paid)
        project.services.update(status: :paid)
      end
      invoice.projects.update(status: :paid)
    end
    Invoice.all.where(status: :paid, payment_id: nil).update(status: :created)
    Project.all.where(status: :paid).joins(:invoice).where("invoices.payment_id IS NULL").update(status: :invoiced)
    Ware.all.where(status: :paid).joins(:project).joins("JOIN invoices ON invoices.id = projects.invoice_id").where("invoices.payment_id IS NULL").update(status: :invoiced)
    Service.all.where(status: :paid).joins(:project).joins("JOIN invoices ON invoices.id = projects.invoice_id").where("invoices.payment_id IS NULL").update(status: :invoiced)
  end

  def do_total(invoices)
    invoices.collect {|w| w.valid? ? w.total : 0}.sum
  end
end
