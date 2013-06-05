require 'spec_helper'

feature 'Blocks > Show' do
  include NamedFactories

  let(:disabled_layer) { create :text_layer, block: block_1a, active: false }

  scenario 'show an flms block as a skrollr animation' do
    disabled_layer
    image_layer_1a1
    image_layer_1b1_inactive
    text_layer_1a1
    paragraph_layer_1a1
    embed_layer_1a1
    animation_layer_1a1
    capybara_sign_in user_1
    visit "/flms/blocks"
    click_link "show-block-#{ block_1a.id }"

    expect(page).to have_selector ".block\##{block_1a.name}"
    expect(page).to have_selector ".image-layer\##{image_layer_1a1.name}"
    expect(page).to have_selector ".text-layer\##{text_layer_1a1.name}"
    expect(page).to have_selector ".paragraph-layer\##{paragraph_layer_1a1.name}"
    expect(page).to have_selector ".embed-layer\##{embed_layer_1a1.name}"
    expect(page).to have_selector ".animation-layer\##{animation_layer_1a1.name}"
    expect(page).not_to have_selector ".text-layer\##{disabled_layer.name}"
  end
end
