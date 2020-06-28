# CarrierWaveの設定呼び出し
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# 保存先
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 'catpia' # 作成したバケット名を記述
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], # 環境変数
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # 環境変数
    region: 'ap-northeast-1',   # アジアパシフィック(東京)を選択した場合
    path_style: true
  }
  config.storage :fog
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/catpia'
end 