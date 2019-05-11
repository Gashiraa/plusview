class Customer < ApplicationRecord
  has_many :invoices, dependent: :nullify
  has_many :quotations, dependent: :nullify
  has_many :projects, dependent: :nullify

  def listmodel
    projects.where('status = 0')
  end
end