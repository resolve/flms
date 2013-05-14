require 'spec_helper'

feature 'Pages > Show' do
  include NamedFactories

  let(:disabled_layer) { create :text_layer, block: block_1a, active: false }

  scenario 'shows the page for a standard html request and only includes active blocks' do
    page_1
    image_layer_1a1
    image_layer_1b1_inactive
    image_layer_1c1
    visit "/flms/pages/#{page_1.url}"
    expect(page.body).to have_content page_1.title
    expect(page).to have_selector ".block\##{block_1a.name}"
    expect(page).not_to have_selector ".block\##{block_1b_inactive.name}"
    expect(page).to have_selector ".block\##{block_1c.name}"
  end

  scenario 'shows the page and includes an unordered list with nav items' do
    page_1
    image_layer_1a1
    image_layer_1c1
    visit "/flms/pages/#{page_1.url}"
    expect(page).to have_selector "li\##{ block_1a.name }"
    expect(page).to have_selector ".name\##{ block_1a.name }"
    expect(page).to have_selector "a\##{ block_1a.name }"
    expect(page).to have_selector "a\##{ block_1c.name }"
  end

end
