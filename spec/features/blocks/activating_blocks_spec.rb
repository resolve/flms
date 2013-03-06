require 'spec_helper'

feature 'Blocks > Activating blocks' do
  test_helpers

  scenario 'activating a block', js: true do
    page_1.blocks.concat block_1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks"
    page.evaluate_script "$('.switch').bootstrapSwitch('setState', true);"
    click_on 'save'
    sleep 0.1

    expect(block_1.reload.blocks_pages.first).to be_active
  end
end

