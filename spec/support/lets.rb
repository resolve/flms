module NamedFactories
  extend ActiveSupport::Concern

  included do
    let(:user) { create :user }
    let(:user_1) { create :user }
    let(:user_2) { create :user }
    let(:page_1) { create :page }
    let(:page_2) { create :page }
    let(:block) { create :block, name: 'block-unassigned' }
    let(:block_1a) { block = create :block, name: 'block-1a'
                     block.blocks_pages.create page: page_1, ordering: 1, active: true
                     block }
    let(:block_1b_inactive) { block = create :block, name: 'block-1b-inactive'
                     block.blocks_pages.create page: page_1, ordering: 2
                     block }
    let(:block_1c) { block = create :block, name: 'block-1c'
                     block.blocks_pages.create page: page_1, ordering: 3, active: true
                     block }
    let(:layer_1a1) { create :layer, block: block_1a }
    let(:layer_1a2) { create :layer, block: block_1a }
    let(:image_layer_1a1) { create :image_layer, block: block_1a }
    let(:image_layer_1a2) { create :image_layer, block: block_1a }
    let(:image_layer_1b1_inactive) { create :image_layer, block: block_1b_inactive }
    let(:image_layer_1c1) { create :image_layer, block: block_1c }
    let(:text_layer_1a1) { create :text_layer, block: block_1a }
    let(:paragraph_layer_1a1) { create :paragraph_layer, block: block_1a }
    let(:embed_layer_1a1) { create :embed_layer, block: block_1a }
    let(:animation_layer_1a1) { create :animation_layer, block: block_1a }

    let(:default_access_granted_check) { response.success? }
  end
end
