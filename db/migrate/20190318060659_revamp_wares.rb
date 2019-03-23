class RevampWares < ActiveRecord::Migration[5.2]
  def change
    rename_column :wares, :name, :ware_name
    add_column :wares, :provider_name, :string
    add_column :wares, :provider_invoice, :string
    add_column :wares, :provider_net, :float
    add_column :wares, :provider_gross, :float
    add_column :wares, :total_gross, :float
  end
end
