class CreateQuotations < ActiveRecord::Migration[5.2]
  def change
    create_table :quotations do |t|
      t.date :date
      t.integer :status
      t.float :total

      t.timestamps
    end
  end
end
