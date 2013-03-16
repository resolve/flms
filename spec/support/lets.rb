module NamedFactories
  extend ActiveSupport::Concern

  included do
    let(:user) { create :user }
    let(:user_1) { create :user }
    let(:user_2) { create :user }
    let(:page_1) { create :page }
    let(:page_2) { create :page }
    let(:block) { create :block }
    let(:block_1a) { block = create :block
                     block.blocks_pages.create page: page_1, ordering: 1
                     block }
    let(:block_1b) { block = create :block
                     block.blocks_pages.create page: page_1, ordering: 2
                     block }
    let(:layer_1a1) { create :layer, block: block_1a, ordering: 1 }
    let(:image_layer_1a1) { create :image_layer, block: block_1a, ordering: 1 }

    let(:default_access_granted_check) { response.success? }
  end
end
