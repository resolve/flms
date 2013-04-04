# encoding: utf-8
require 'carrierwave'
require 'carrierwave/processing/mime_types'
require 'carrierwave/orm/activerecord'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  process :set_content_type

  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  version :small do
    process resize_to_fit: [200, 200]
  end

  version :thumb, from_version: :small do
    process resize_to_fill: [48, 48]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
