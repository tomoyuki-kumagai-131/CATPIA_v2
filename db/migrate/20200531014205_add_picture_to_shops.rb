class AddPictureToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :picture, :string
  end
end
