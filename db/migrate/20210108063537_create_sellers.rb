class CreateSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.string :username
      t.string :password
      t.string :email

      t.timestamps
    end
  end
end
