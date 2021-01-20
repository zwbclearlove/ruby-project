class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.text :address
      t.text :description
      t.string :telephone

      t.timestamps
    end
  end
end
