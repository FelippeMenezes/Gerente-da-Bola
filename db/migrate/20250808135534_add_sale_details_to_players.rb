class AddSaleDetailsToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :for_sale, :boolean, default: false
  end
end
