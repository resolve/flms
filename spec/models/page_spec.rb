require 'spec_helper'

describe Flms::Page do
  include NamedFactories

  subject { create :page }
  let(:subject_with_block) { subject.blocks << block ; subject }

  describe 'associations' do
    it 'has blocks' do
      expect(subject_with_block).to have(1).blocks
      expect(subject_with_block.blocks.first).to eql block
    end
  end

  describe 'ordered_blocks_pages' do

    it 'returns the blocks_pages for the page, ordered by "ordering"' do
      block_1b
      block_1a

      result = page_1.ordered_blocks_pages
      expect(result).to have(2).instances
      expect(result[0].ordering).to eql 1
      expect(result[1].ordering).to eql 2
      expect(result[0].block).to eq block_1a
      expect(result[1].block).to eq block_1b
    end
  end

  describe 'position_for_block' do
    it 'returns the "blocks_pages" object for the given block on this page' do
      result = subject_with_block.position_for_block(block.id)
      expect(result.page).to eq subject
      expect(result.block).to eq block
    end
  end
end

