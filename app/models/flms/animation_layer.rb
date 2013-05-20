module Flms
  class AnimationLayer < Layer
    attr_accessible :image, :image_cache,
                    :frame_count, :frame_rate,
                    :image_width, :image_height,
                    :image_display_mode

    mount_uploader :image, ImageUploader
    before_save :retain_geometry

    validates_inclusion_of :image_display_mode, in: Flms::Layer::IMAGE_DISPLAY_MODES
    validates_numericality_of :frame_count, greater_than_or_equal_to: 1
    validates_numericality_of :frame_rate, greater_than_or_equal_to: 1

    def view_object
      @view_object ||= Flms::AnimationLayerViewObject.new(self)
    end

    def uploaded_filename
      File.basename(image.path) if image?
    end

    # Pull geometry information out of uploaded file and store as attributes in
    # model prior to save.  See image_uploader.rb#get_geometry.
    def retain_geometry
      geometry = self.image.normal.geometry
      if geometry
        self.image_width = geometry[0]
        self.image_height = geometry[1]
      end
    end
  end
end
