require 'spec_helper'

describe Flms::LayerSerializer do
  include ActiveModel::Serializers::Matchers

  let(:subject) { Flms::LayerSerializer }

  it 'serializes with the desired attributes' do
    expect(subject).to have_attribute(:name)
    expect(subject).to have_attribute(:type)
  end

  it 'includes desired associations' do
    expect(subject).to have_many(:keyframes)
  end
end
