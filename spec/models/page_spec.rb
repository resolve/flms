require 'spec_helper'

describe Flms::Page do
  test_helpers

  describe 'associations' do
    it 'has blocks' do
      page_1.blocks << block_1
      expect(page_1).to have(1).blocks
      expect(page_1.blocks.first).to eql block_1
    end
  end
end


