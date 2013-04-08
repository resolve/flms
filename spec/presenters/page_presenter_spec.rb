require 'spec_helper'

describe Flms::PagePresenter do
  include NamedFactories

  describe 'to_html' do
    it 'includes layers from all active blocks' do
      image_layer_1a1
      image_layer_1a2
      image_layer_1b1
      image_layer_1c1
      output = Flms::PagePresenter.new(page_1).to_html
      expect(output.scan('<img').length).to eql 3
    end
  end

end
