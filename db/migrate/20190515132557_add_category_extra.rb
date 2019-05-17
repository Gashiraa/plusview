class AddCategoryExtra < ActiveRecord::Migration[5.2]
  def change
    add_column :extras, :category, :string
  end
end
