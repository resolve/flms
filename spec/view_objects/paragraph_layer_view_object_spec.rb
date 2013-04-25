require 'spec_helper'

describe Flms::ParagraphLayerViewObject do
  let(:paragraph_layer) { create :paragraph_layer, color: 'abc',
                                 header: 'header text', body: 'body text' }
  let(:subject) { Flms::ParagraphLayerViewObject.new(paragraph_layer) }

  describe 'attributes' do
    let(:data) { subject.attributes }

    it 'should include color styling' do
      expect(data).to have_key :style
      expect(data[:style]).to match 'color: #abc;'
    end

    it 'should include basic attributes' do
      expect(data).to have_key 'data-0'
      expect(data).to have_key 'data-100'
      expect(data).to have_key 'data-200'
      expect(data).to have_key 'data-300'
    end
  end
end
