require 'spec_helper'

describe Flms::TextLayerViewObject do
  let(:text_layer) { create :text_layer, font_size: 1.0, color: 'abc' }
  let(:view_object) { Flms::TextLayerViewObject.new(text_layer) }

  describe 'attributes' do
    let(:data) { view_object.attributes }

    it 'should include styling' do
      expect(data).to have_key 'style'
      expect(data['style']).to match 'font-size: 1.0em;'
      expect(data['style']).to match 'color: #abc;'
    end
  end
end
