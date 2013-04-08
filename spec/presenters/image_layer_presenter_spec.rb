require 'spec_helper'

describe Flms::ImageLayerPresenter do
  let(:image_layer) { create :image_layer }
  let(:presenter) { Flms::ImageLayerPresenter.new(image_layer) }

  describe 'to_html' do
    it 'generates correct img tag' do
      expect(presenter.to_html).to match "<img "
      expect(presenter.to_html).to match "\\>"
    end

    it 'includes image url' do
      expect(presenter.to_html).to match "src='/uploads/flms/image_layer/image/1/placeholder.png'"
    end

    it 'includes data' do
      expect(presenter.to_html).to match "data-"
    end
  end

end
