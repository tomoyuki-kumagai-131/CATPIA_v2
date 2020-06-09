require 'rails_helper'
# Notificaionモデルのバリデーションテスト
RSpec.describe Notification, type: :model do
  let!(:notification) { create(:notification) }

  it "notificationインスタンスが有効であること" do
    expect(notification).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    notification.user_id = nil
    expect(notification).not_to be_valid
  end

  it "shop_idがnilの場合、無効であること" do
    notification.shop_id = nil
    expect(notification).not_to be_valid
  end

  it "varietyがnilの場合、無効であること" do
    notification.variety = nil
    expect(notification).not_to be_valid
  end

  it "from_user_idがnilの場合、無効であること" do
    notification.from_user_id = nil
    expect(notification).not_to be_valid
  end
end
