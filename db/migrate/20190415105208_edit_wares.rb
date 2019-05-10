class EditWares < ActiveRecord::Migration[5.2]
  def change
    rename_column :wares, :unit_price, :provider_price
    rename_column :wares, :provider_net, :bought_price
    add_column :wares, :sell_price, :float
  end
end
