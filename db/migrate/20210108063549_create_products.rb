class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :stock
      t.integer :sales
      t.text :description

      t.timestamps
    end
  end
end
