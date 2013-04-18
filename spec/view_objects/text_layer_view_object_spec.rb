require 'spec_helper'

describe Flms::TextLayerViewObject do
  let(:text_layer) { create :text_layer,
                            font_size: 1.0, color: 'abc',
                            start_state_keyframe_attributes: { scale: 0.2 },
                            target_state_keyframe_attributes: { scale: 0.3 },
                            end_state_keyframe_attributes: { scale: 0.4 } }
  let(:view_object) { Flms::TextLayerViewObject.new(text_layer) }

  describe 'attributes' do
    let(:data) { view_object.attributes }

    it 'should include styling and font size' do
      expect(data).to have_key :style
      expect(data[:style]).to match 'color: #abc;'
      expect(data['data-0']).to match 'font-size:'
      expect(data['data-100']).to match 'font-size:'
      expect(data['data-200']).to match 'font-size:'
      expect(data['data-300']).to match 'font-size:'
    end
  end

  describe 'keyframe_font_sizes' do
    it 'generates font sizes correctly based on scale of each keyframe' do
      data = view_object.keyframe_font_sizes(1)
      expect(data['data-1']).to eql " font-size: 0.2em;"
      expect(data['data-101']).to eql " font-size: 0.3em;"
      expect(data['data-201']).to eql " font-size: 0.3em;"
      expect(data['data-301']).to eql " font-size: 0.4em;"
    end
  end
end
