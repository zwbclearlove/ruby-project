class AddPtypeIdToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_type_id, :integer
    add_column :products, :shop_id, :integer
  end
end
