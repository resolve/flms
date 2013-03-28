require 'spec_helper'

describe Flms::StartStateKeyframe do
  describe 'defaults' do
    it 'initializes correct defaults for a start keyframe' do
      k = Flms::StartStateKeyframe.new
      expect(k.scroll_start).to eql 0
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