class CustomerNumbertoString < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :number, :string
  end
end
