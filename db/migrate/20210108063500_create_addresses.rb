class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.text :address
      t.string :receiver
      t.string :phone

      t.timestamps
    end
  end
end
