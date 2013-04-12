module Flms
  class Block < ActiveRecord::Base
    attr_accessible :name

    has_many :blocks_pages, class_name: 'Flms::BlocksPage', dependent: :destroy
    has_many :pages, through: :blocks_pages, class_name: 'Flms::Page'
    has_many :layers

    validates :name, presence: true

    scope :ordered, order('ordering')

    # Return the total scroll duration for this block, taking in to account the fact that
    # layers can and will overlap
    def scroll_duration
      layers.map(&:scroll_end).max
    end
  end
end
