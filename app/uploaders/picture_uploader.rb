class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
    storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
     "/images/" + [version_name, "default.png"].compact.join('_')
  end

  # 画像サイズ設定
  # 詳細表示用：400 * 400の正方形に整形
  version :thumb600 do
    process resize_and_pad(600, 600, background = :transparent, gravity = 'Center')
  end

  # 一覧表示用：200 * 200の正方形に中央から切り抜き
  version :thumb400 do
    process resize_to_fill: [400, 400, "Center"]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    original_filename if original_filename
  end
end
