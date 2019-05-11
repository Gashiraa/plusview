class ReSwap11QuotationProject < ActiveRecord::Migration[5.2]
  def change
    remove_reference :quotations, :project, index: true, foreign_key: true
    add_reference :projects, :quotation, index: true, foreign_key: true
  end
end
