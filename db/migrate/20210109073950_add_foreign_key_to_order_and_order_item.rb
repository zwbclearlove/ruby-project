class AddForeignKeyToOrderAndOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :shop_id, :integer
    add_column :orders, :user_id, :integer
    add_column :orders, :address_id, :integer
    add_column :order_items, :order_id, :integer
    add_column :order_items, :product_id, :integer
  end
end
