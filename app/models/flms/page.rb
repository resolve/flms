module Flms
  class Page < ActiveRecord::Base
    attr_accessible :title, :url

    has_many :blocks_pages, dependent: :destroy
    has_many :blocks, through: :blocks_pages
    has_many :active_blocks, source: :block, through: :blocks_pages, conditions: ['active = ?', true ], order: 'ordering'

    validates :title, :url, presence: true

    # Returns the blocks_pages of this page, in the right order to display them.
    def ordered_blocks_pages
      blocks_pages.by_ordering
    end

    # Returns the BlocksPage object for the given block on this page.
    def position_for_block block_id
      blocks_pages.where(block_id: block_id).first
    end

    # For creating URLs.
    def to_param
      url
    end
  end
end
