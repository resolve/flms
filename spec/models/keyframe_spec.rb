require 'spec_helper'

describe Flms::Keyframe do
  describe 'translation accessors' do
    describe 'opacity_percent' do
      it 'sets opacity correctly' do
        expect(Flms::Keyframe.new(opacity_percent: 50).opacity).to eql 0.5
      end

      it 'gets opacity correctly' do
        expect(Flms::Keyframe.new(opacity: 0.5).opacity_percent).to eql 50
      end
    end

    describe 'scale_percent' do
      it 'sets scale correctly' do
        expect(Flms::Keyframe.new(scale_percent: 50).scale).to eql 0.5
      end

      it 'gets scale correctly' do
        expect(Flms::Keyframe.new(scale: 0.5).scale_percent).to eql 50
      end
    end

    describe 'blur_percent' do
      it 'sets blur correctly' do
        expect(Flms::Keyframe.new(blur_percent: 50).blur).to eql 0.5
      end

      it 'gets blur correctly' do
        expect(Flms::Keyframe.new(blur: 0.5).blur_percent).to eql 50
      end
    end
  end

end