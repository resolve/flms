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

  describe 'validation' do
    describe 'for name' do
      describe 'css validity' do
        def fail_test name
          block.update_attributes name: name
          expect(block).to have(1).error_on(:name)
        end

        def pass_test name
          block.update_attributes name: name
          expect(block).to have(0).errors_on(:name)
        end

        it 'does not accept names with whitespace' do
          fail_test 'this is an invalid css class'
        end

        it 'does not accept names with numbers in front' do
          fail_test '123-no-way-jose'
        end

        it 'does not accept names with a period in front' do
          fail_test '.otherwise-ok'
        end

        it 'accepts a valid css name' do
          pass_test 'this-is_a_valid_css-class-12345'
        end
      end
    end
  end

  describe 'scroll_duration' do
    let(:block) { create :block }
    let!(:layer_1) { l = block.layers.build(name: 'abc').build_default_keyframes
                     l.start_state_keyframe.scroll_start = 1
                     l.save! }
    let!(:layer_2) { l = block.layers.build(name: 'def').build_default_keyframes
                     l.start_state_keyframe.scroll_start = 2
                     l.save! }

    it 'returns the total scroll duration for the block' do
      expect(block.scroll_duration).to eql 302
    end
  end
end

