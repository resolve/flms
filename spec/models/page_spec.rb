require 'spec_helper'

describe Flms::Page do
  include NamedFactories

  subject { create :page }
  let(:subject_with_block) { subject.blocks << block; subject }

  describe 'associations' do
    describe 'blocks' do
      it 'has blocks' do
        expect(subject_with_block).to have(1).blocks
        expect(subject_with_block.blocks.first).to eql block
      end
    end

    describe 'active_blocks' do
      let(:result) { page_1.active_blocks }

      before do
        block_1c
        block_1b_inactive
        block_1a
      end

      it 'orders blocks by ordering' do
        expect(result[0]).to eql block_1a
        expect(result[1]).to eql block_1c
      end

      it 'lists only active blocks' do
        result = page_1.active_blocks
        expect(result.count).to eql 2
        expect(result).not_to include block_1b_inactive
      end
    end

    describe 'active blocks pages' do
      it 'lists only blocks_pages that link to active blocks' do
        block_1c
        block_1b_inactive
        block_1a
        result = page_1.blocks_pages.ordered.is_active
        expect(result.count).to eql 2
      end
    end
  end

  describe 'ordered_blocks_pages' do
    it 'returns the blocks_pages for the page, ordered by "ordering"' do
      block_1b_inactive
      block_1a

      result = page_1.ordered_blocks_pages
      expect(result).to have(2).instances
      expect(result[0].ordering).to eql 1
      expect(result[1].ordering).to eql 2
      expect(result[0].block).to eq block_1a
      expect(result[1].block).to eq block_1b_inactive
    end
  end

  describe 'position_for_block' do
    it 'returns the "blocks_pages" object for the given block on this page' do
      result = subject_with_block.position_for_block(block.id)
      expect(result.page).to eq subject
      expect(result.block).to eq block
    end
  end

  describe 'blocks_to_display_with_offsets' do
    it 'returns active, ordered blocks with correct scroll offsets' do
      image_layer_1a1
      image_layer_1b1_inactive
      image_layer_1c1
      result = page_1.blocks_to_display_with_offsets

      expect(result.length).to eql 2

      expected_scroll_offset = 0
      result.each do |item|
        expect(item[:block].class).to eql Flms::Block
        expect(item[:scroll_offset]).to eql expected_scroll_offset
        expected_scroll_offset += item[:block].scroll_duration
      end
    end
  end
end

