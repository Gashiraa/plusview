class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.references :invoice, foreign_key: true
      t.references :quotation, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :status
      t.integer :wielding
      t.integer :machining
      t.integer :karcher

      t.timestamps
    end
  end
end
