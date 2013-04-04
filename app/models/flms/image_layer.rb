module Flms
  class ImageLayer < Layer
    attr_accessible :image, :image_cache

    mount_uploader :image, ImageUploader

    def uploaded_filename
      File.basename(image.path) if image?
    end
  end
end

