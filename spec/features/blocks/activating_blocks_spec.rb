require 'spec_helper'

feature 'Blocks > Activating blocks' do
  include NamedFactories

  scenario 'activating a block', js: true do
    block_1a

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks"
    page.evaluate_script "$('.switch').bootstrapSwitch('setState', true);"
    click_on 'save'
    sleep 0.1

    expect(block_1a.reload.blocks_pages.first).to be_active
  end
end

