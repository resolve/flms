module Flms
  class Page < ActiveRecord::Base
    attr_accessible :title, :url

    has_many :blocks_pages, dependent: :destroy
    has_many :blocks, through: :blocks_pages
    has_many :active_blocks, source: :block, through: :blocks_pages, conditions: ['active = ?', true ], order: 'ordering'

    validates :title, :url, presence: true

    # Returns the blocks_pages of this page, in the right order to display them.
    def ordered_blocks_pages
      blocks_pages.ordered
    end

    # Returns the BlocksPage object for the given block on this page.
    def position_for_block block_id
      blocks_pages.where(block_id: block_id).first
    end

    # For creating URLs.
    def to_param
      url
    end

    # Returns an array containing blocks and associated scroll offsets for display.
    def blocks_to_display_with_offsets
      scroll_offset = 0
      blocks_for_display = []
      blocks_pages.ordered.is_active.each do |block_page|
        blocks_for_display << { block: block_page.block, scroll_offset: scroll_offset }
        scroll_offset += block_page.block.scroll_duration
      end
      blocks_for_display
    end
  end
end
