class AddPriceAndStockToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :price, :decimal
    add_column :products, :stock, :integer
  end
end
