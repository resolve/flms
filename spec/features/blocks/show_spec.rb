require 'spec_helper'

feature 'Blocks > Show' do
  test_helpers

  scenario 'editing an existing block' do
    page_1.blocks << block_1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1.id}"
    expect(page).to have_content ''
  end
end

