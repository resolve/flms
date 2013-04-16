require 'spec_helper'

feature 'Pages > Show' do
  include NamedFactories

  scenario 'shows the page for a standard html request' do
    page_1
    image_layer_1a1
    image_layer_1b1_inactive
    image_layer_1c1
    text_layer_1a1
    visit "/flms/pages/#{page_1.url}"
    expect(page.body).to have_content page_1.title

    expect(page).to have_selector ".block\##{block_1a.name}"
    expect(page).to have_selector ".image-layer\##{image_layer_1a1.name}"
    expect(page).to have_selector ".image-layer\##{image_layer_1c1.name}"
    expect(page).to have_selector ".text-layer\##{text_layer_1a1.name}"
  end

end
