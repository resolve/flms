require 'spec_helper'

feature 'Blocks > Create' do
  test_helpers

  scenario 'creating a new block' do
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks"
    click_link 'New Block'
    fill_in 'Name', with: 'my new block'
    click_button 'Create Block'

    expect(Flms::Block).to have(1).instances
    expect(page_1.reload).to have(1).blocks
    block = page_1.blocks.first
    expect(block.name).to eql 'my new block'
  end
end

