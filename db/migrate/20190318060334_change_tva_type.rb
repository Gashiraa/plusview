class ChangeTvaType < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :tva_record, :string
  end
end
