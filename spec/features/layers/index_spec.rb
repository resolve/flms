require 'spec_helper'

feature 'Layers > Index' do
  include NamedFactories

  scenario 'creating a new layer' do
    layer_1a1
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    expect(page).to have_content layer_1a1.name
  end
end
