require 'spec_helper'

feature 'Blocks > Show' do
  include NamedFactories

  scenario 'editing an existing block' do
    block_1a

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"
    expect(page).to have_content 'Name'
    expect(page).to have_content 'Thumbnail'
    expect(page).to have_content 'Starts'
    expect(page).to have_content 'Ends'
    expect(page).to have_content 'Z-Index'
  end
end
