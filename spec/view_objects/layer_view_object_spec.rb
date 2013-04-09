require 'spec_helper'

describe Flms::LayerViewObject do
  let(:presenter) { Flms::LayerViewObject.new(create :layer) }

  describe 'keyframe_data_hash' do
    let(:data) { presenter.keyframe_data_hash }

    it 'anchors to correct target' do
      expect(data['data-anchor-target']).to eql '#pagescroller'
    end

    it 'generates scroll positions correctly' do
      expect(data).to have_key 'data-0'
      expect(data).to have_key 'data-100'
      expect(data).to have_key 'data-200'
      expect(data).to have_key 'data-300'
    end
  end
end
