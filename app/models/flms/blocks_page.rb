module Flms
  class BlocksPage < ActiveRecord::Base
    attr_accessible :block_id, :block, :page_id, :ordering, :active

    belongs_to :block, class_name: 'Flms::Block'
    belongs_to :page, class_name: 'Flms::Page'
  end
end
