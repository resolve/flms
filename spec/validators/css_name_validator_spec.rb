require 'spec_helper'

class Validatable
  include ActiveModel::Validations
  attr_accessor :name
  validates :name, :'flms/css_name' => true
end

RSpec::Matchers.define :accept_css_name do |name|
  match do |subject|
    subject.name = name
    subject.valid?
  end
end

describe Flms::CssNameValidator do
  subject { Validatable.new }

  it 'does not accept names with whitespace' do
    expect(subject).to_not accept_css_name 'this is an invalid css name'
  end

  it 'does not accept names with numbers in front' do
    expect(subject).to_not accept_css_name '123-no-way-jose'
  end

  it 'does not accept names with a period in front' do
    expect(subject).to_not accept_css_name '.otherwise-ok'
  end

  it 'accepts a valid css name' do
    expect(subject).to accept_css_name 'this-is_a_valid_css-class-12345'
  end
end
