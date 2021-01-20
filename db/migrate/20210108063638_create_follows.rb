class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.timestamp :follow_time

      t.timestamps
    end
  end
end
