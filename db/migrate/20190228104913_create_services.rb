class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.references :project, foreign_key: true
      t.references :invoice, foreign_key: true
      t.references :customer, foreign_key: true
      t.references :quotation, foreign_key: true
      t.string :name
      t.string :comment
      t.float :hourly_rate
      t.float :coefficient
      t.date :date
      t.time :duration
      t.integer :status
      t.float :tva_rate
      t.float :total_cost

      t.timestamps
    end
  end
end
