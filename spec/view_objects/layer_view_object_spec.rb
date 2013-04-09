require 'spec_helper'

describe Flms::LayerViewObject do
  let(:presenter) { Flms::LayerViewObject.new(create :layer) }

  describe 'render_keyframe_data_attributes' do
    let(:data) { presenter.keyframe_data }
    let(:test_data_hash) { { :'key_1' => 'value 1', :'key_2' => 'value 2', :'key_3' => 'value 3' } }

    it 'concatenates data into a string we can use in an html tag' do
      expect(presenter.render_keyframe_data_attributes(test_data_hash)).to eql "key_1='value 1' key_2='value 2' key_3='value 3'"
    end
  end

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
