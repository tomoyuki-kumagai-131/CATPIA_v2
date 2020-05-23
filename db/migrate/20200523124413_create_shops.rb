class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :web_page
      t.text :description
      t.text :recommended_points
      t.integer :rating
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :shops, [:user_id, :created_at]
  end
end
