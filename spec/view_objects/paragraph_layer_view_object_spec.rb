require 'spec_helper'

describe Flms::ParagraphLayerViewObject do
  let(:paragraph_layer) { create :paragraph_layer,
                                 header: 'header text', body: 'body text' }
  let(:view_object) { Flms::ParagraphLayerViewObject.new(paragraph_layer) }

  describe 'attributes' do
    let(:data) { view_object.attributes }

    it 'should include basic attributes' do
      expect(data).to have_key 'data-0'
      expect(data).to have_key 'data-100'
      expect(data).to have_key 'data-200'
      expect(data).to have_key 'data-300'
    end
  end
end
