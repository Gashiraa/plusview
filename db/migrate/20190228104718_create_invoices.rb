class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :payment, foreign_key: true
      t.date :date
      t.integer :status
      t.float :total

      t.timestamps
    end
  end
end
