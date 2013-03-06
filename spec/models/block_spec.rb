require 'spec_helper'

describe Flms::Block do
  test_helpers

  describe 'associations' do
    it 'has pages' do
      block_1.pages << page_1
      expect(block_1).to have(1).pages
      expect(block_1.pages.first).to eql page_1
    end
  end
end

