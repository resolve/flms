module Flms
  class Block < ActiveRecord::Base
    attr_accessible :name

    has_many :blocks_pages, class_name: 'Flms::BlocksPage', dependent: :destroy
    has_many :pages, through: :blocks_pages, class_name: 'Flms::Page'
    has_many :layers

    validates :name, presence: true
    validate :name, :is_valid_css_id

    scope :ordered, order('ordering')

    # Return the total scroll duration for this block, taking in to account the fact that
    # layers can and will overlap
    def scroll_duration
      layers.map(&:scroll_end).max
    end

    private

    def is_valid_css_id
      self.errors[:name] << 'must be a valid CSS ID' unless name =~ /^[_a-zA-Z]+[_a-zA-Z0-9-]*$/
    end
  end
end
