module Flms
  class Block < ActiveRecord::Base
    attr_accessible :name, :title, :thumbnail

    has_many :blocks_pages, class_name: 'Flms::BlocksPage', dependent: :destroy
    has_many :pages, through: :blocks_pages, class_name: 'Flms::Page'
    has_many :layers

    mount_uploader :thumbnail, ThumbnailImageUploader

    validates :name, presence: true
    validates :name, :'flms/css_name' => true

    scope :ordered, order('ordering')

    # Return the total scroll duration for this block, taking in to account the fact that
    # layers can and will overlap.  Return 0 if block has no layers.
    def scroll_duration
      layers.map(&:scroll_end).max || 0
    end

  def thumbnail_uploaded_filename
    File.basename(thumbnail.path) if thumbnail?
  end

  end
end
