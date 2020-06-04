class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :shop_id

      t.timestamps
    end
    add_index :favorites, [:user_id, :shop_id], unique: true # user_idとshop_idの組み合わせはユニークである
  end
end
