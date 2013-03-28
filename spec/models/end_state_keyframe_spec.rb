require 'spec_helper'

describe Flms::EndStateKeyframe do
  describe 'defaults' do
    it 'initializes correct defaults for an end keyframe' do
      k = Flms::EndStateKeyframe.new
      expect(k.scroll_start).to eql nil
      expect(k.scroll_duration).to eql 100
      expect(k.width).to eql 1.0
      expect(k.height).to eql 1.0
      expect(k.position_x).to eql 0.5
      expect(k.position_y).to eql 0.5
      expect(k.opacity).to eql 0.0
      expect(k.scale).to eql 1.0
      expect(k.blur).to eql 0.0
    end
  end
end