class AddForeignKeyToMessage < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :from_id
    remove_column :messages, :to_id
    add_column :messages, :user_id, :integer
    add_column :messages, :shop_id, :integer
  end
end
