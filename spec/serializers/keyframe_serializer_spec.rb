require 'spec_helper'

describe Flms::KeyframeSerializer do
  include ActiveModel::Serializers::Matchers

  let(:subject) { Flms::KeyframeSerializer }

  it 'serializes with the desired attributes' do
    expect(subject).to have_attribute(:scroll_start)
    expect(subject).to have_attribute(:scroll_duration)
    expect(subject).to have_attribute(:width)
    expect(subject).to have_attribute(:height)
    expect(subject).to have_attribute(:position_x)
    expect(subject).to have_attribute(:position_y)
    expect(subject).to have_attribute(:opacity)
    expect(subject).to have_attribute(:scale)
    expect(subject).to have_attribute(:blur)
  end
end
