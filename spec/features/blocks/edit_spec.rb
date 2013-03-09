require 'spec_helper'

feature 'Blocks > Edit' do
  include NamedFactories

  scenario 'editing an existing block' do
    page_1.blocks << block_1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks"
    click_link 'edit'
    fill_in 'Name', with: 'new block name'
    click_button 'Update Block'

    expect(Flms::Block).to have(1).instances
    block = page_1.reload.blocks.first
    expect(block.name).to eql 'new block name'
  end
end

