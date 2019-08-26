class AddShortCompanyName < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :short_name, :string
  end
end
