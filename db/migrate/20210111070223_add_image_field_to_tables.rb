class AddImageFieldToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image, :string, null: true
    add_column :shops, :image, :string, null: true
    add_column :products, :image, :string, null: true

  end
end
