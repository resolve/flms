require 'spec_helper'

describe Flms::ImageLayerSerializer do
  include ActiveModel::Serializers::Matchers

  let(:subject) { Flms::ImageLayerSerializer }

  it 'serializes with the desired attributes' do
    expect(subject).to have_attribute(:type)
    expect(subject).to have_attribute(:url)
  end
end
