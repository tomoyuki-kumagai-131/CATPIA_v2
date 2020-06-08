class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :shop_id
      t.integer :from_user_id
      t.text :content
      t.integer :variety

      t.timestamps
    end
    add_index :notifications, :user_id 
  end
end
