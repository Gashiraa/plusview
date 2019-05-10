class Swap11QuotationProject < ActiveRecord::Migration[5.2]
  def change
    remove_reference :projects, :quotation, index: true, foreign_key: true
  end
end
