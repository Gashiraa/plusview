class CreateWares < ActiveRecord::Migration[5.2]
  def change
    create_table :wares do |t|
      t.references :project, foreign_key: true
      t.references :invoice, foreign_key: true
      t.references :customer, foreign_key: true
      t.references :quotation, foreign_key: true
      t.string :name
      t.string :comment
      t.integer :quantity
      t.float :provider_discount
      t.float :margin
      t.float :unit_price
      t.integer :status
      t.float :tva_rate
      t.float :total_cost

      t.timestamps
    end
  end
end
