class AddFlagDeleteExtra < ActiveRecord::Migration[5.2]
  def change
    add_column :extras, :delete_flag, :boolean
  end
end
