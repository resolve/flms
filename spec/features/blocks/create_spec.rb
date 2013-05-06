require 'spec_helper'

feature 'Blocks > Create' do
  include NamedFactories

  scenario 'creating a new block' do
    capybara_sign_in user_1
    visit "/flms/blocks"
    click_link 'New Block'
    fill_in 'Name', with: 'my-new-block'
    click_button 'Create Block'

    expect(Flms::Block).to have(1).instances
    expect(Flms::Block.first.name).to eql 'my-new-block'
  end
end
