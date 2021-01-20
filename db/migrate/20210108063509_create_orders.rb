class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.integer :order_status
      t.float :order_price
      t.datetime :order_date

      t.timestamps
    end
  end
end
