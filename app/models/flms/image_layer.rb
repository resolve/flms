module Flms
  class ImageLayer < Layer
    attr_accessible :image, :image_cache

    mount_uploader :image, ImageUploader
    before_save :retain_geometry

    def view_object
      @view_object ||= Flms::ImageLayerViewObject.new(self)
    end

    def uploaded_filename
      File.basename(image.path) if image?
    end

    # Pull geometry information out of uploaded file and store as attributes in
    # model prior to save.  See image_uploader.rb#get_geometry.
    def retain_geometry
      geometry = self.image.normal.geometry
      if geometry
        self.width = geometry[0]
        self.height = geometry[1]
      end
    end
  end
end

