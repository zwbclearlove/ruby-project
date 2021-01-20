class AddSellerIdToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :seller_id, :integer
  end
end
