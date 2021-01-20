class AddForeignKeyToFollow < ActiveRecord::Migration[6.0]
  def change
    add_column :follows, :shop_id, :integer
    add_column :follows, :user_id, :integer
  end
end
