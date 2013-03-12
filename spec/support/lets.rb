module NamedFactories
  extend ActiveSupport::Concern

  included do
    let(:user_1) { create :user }
    let(:user_2) { create :user }
    let(:page_1) { create :page }
    let(:page_2) { create :page }
    let(:block) { create :block }
    let(:block_1a) do
      block = create :block
      block.blocks_pages.create page: page_1, ordering: 1
      block
    end
    let(:block_1b) do
      block = create :block
      block.blocks_pages.create page: page_1, ordering: 2
      block
    end
    let(:default_access_granted_check) { response.success? }
  end
end
