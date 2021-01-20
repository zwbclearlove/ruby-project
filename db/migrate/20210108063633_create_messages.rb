class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.timestamp :create_date
      t.integer :type
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
