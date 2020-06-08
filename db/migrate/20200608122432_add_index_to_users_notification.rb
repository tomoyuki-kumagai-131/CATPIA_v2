class AddIndexToUsersNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notification, :boolean, default: false #boolean型のカラムを追記のため、default値を設定
  end
end
