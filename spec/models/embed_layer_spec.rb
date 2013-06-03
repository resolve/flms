require 'spec_helper'

describe Flms::EmbedLayer do
  include NamedFactories

  describe 'view_object' do
    it 'provides a view object' do
      expect(subject.view_object).to be_a Flms::EmbedLayerViewObject
    end
  end

  describe 'validation' do
    describe 'url' do
      it 'does not permit null url' do
        embed_layer_1a1.update_attribute(:embed_code, nil)
        expect(embed_layer_1a1).to have(1).error_on(:embed_code)
      end
    end
  end

end
