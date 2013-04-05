require 'spec_helper'

describe Flms::BlockSerializer do
  include ActiveModel::Serializers::Matchers

  let(:subject) { Flms::BlockSerializer }

  it 'includes desired associations' do
    expect(subject).to have_many(:layers)
  end
end
