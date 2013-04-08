require 'spec_helper'

describe Flms::LayerPresenter do
  let(:presenter) { Flms::LayerPresenter.new(create :layer) }

  describe 'keyframe_data' do
    let(:data) { presenter.keyframe_data }
    let(:test_data_hash) { { :'key_1' => 'value 1', :'key_2' => 'value 2', :'key_3' => 'value 3' } }

    it 'concatenates data into a string we can use in an html tag' do
      presenter.stub(:keyframe_data_hash) { test_data_hash }
      expect(presenter.keyframe_data).to eql "key_1='value 1' key_2='value 2' key_3='value 3'"
    end
  end

  describe 'keyframe_data_hash' do
    let(:data) { presenter.keyframe_data_hash }

    it 'anchors to correct target' do
      expect(data['data-anchor-target']).to eql '#pagescroller'
    end

    it 'generates scroll positions correctly' do
      expect(data).to have_key 'data-0-top'
      expect(data).to have_key 'data-100-top'
      expect(data).to have_key 'data-200-top'
      expect(data).to have_key 'data-300-top'
    end
  end
end
