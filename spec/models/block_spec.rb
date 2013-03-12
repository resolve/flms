require 'spec_helper'

describe Flms::Block do
  include NamedFactories

  describe 'associations' do
    it 'has pages' do
      block.pages << page_1
      expect(block).to have(1).pages
      expect(block.pages.first).to eql page_1
    end
  end
end

