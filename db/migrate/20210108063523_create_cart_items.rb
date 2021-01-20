class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.string :product_name
      t.integer :product_number

      t.timestamps
    end
  end
end
