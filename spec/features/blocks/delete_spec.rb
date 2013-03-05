require 'spec_helper'

feature 'Blocks > Delete' do
  test_helpers

  scenario 'deleting a new block', js: true do
    page_1.blocks << block_1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks"
    page.evaluate_script 'window.confirm = function() { return true; }'
    click_link 'delete'

    expect(Flms::Block).to have(0).instances
  end
end

