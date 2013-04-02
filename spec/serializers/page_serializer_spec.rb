require 'spec_helper'

describe Flms::PageSerializer do
  include ActiveModel::Serializers::Matchers

  let(:subject) { Flms::PageSerializer }

  it 'serializes with the desired attributes' do
    expect(subject).to have_attribute(:name)
    expect(subject).to have_attribute(:description)
    expect(subject).to have_attribute(:thumbnail)
  end

  it 'includes desired associations' do
    expect(subject).to have_many(:active_blocks)
  end
end
