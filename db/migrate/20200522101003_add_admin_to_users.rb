class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false # デフォルトでは一般ユーザーにするためfalse
  end
end
