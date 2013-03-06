require 'spec_helper'

describe Flms::Page do
  test_helpers

  subject { create :page }
  let(:subject_with_block_1) { subject.blocks << block_1 ; subject }

  describe 'associations' do
    it 'has blocks' do
      expect(subject_with_block_1).to have(1).blocks
      expect(subject_with_block_1.blocks.first).to eql block_1
    end
  end

  describe 'ordered_blocks_pages' do

    it 'returns the blocks_pages for the page, ordered by "ordering"' do
      page_1.blocks_pages.create ordering: 2, block: block_1
      page_1.blocks_pages.create ordering: 1, block: block_2

      result = page_1.ordered_blocks_pages
      expect(result).to have(2).instances
      expect(result[0].ordering).to eql 1
      expect(result[1].ordering).to eql 2
      expect(result[0].block).to eq block_2
      expect(result[1].block).to eq block_1
    end
  end

  describe 'position_for_block' do
    it 'returns the "blocks_pages" object for the given block on this page' do
      result = subject_with_block_1.position_for_block(block_1.id)
      expect(result.page).to eq subject
      expect(result.block).to eq block_1
    end
  end
end

