module Flms
  class ImageLayer < Layer
    attr_accessible :image

    mount_uploader :image, ImageUploader

  end
end

