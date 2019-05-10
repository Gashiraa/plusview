class New11QuotationProject < ActiveRecord::Migration[5.2]
  def change
    add_reference  :quotations, :project, index: true, foreign_key: true
  end
end
