require 'spec_helper'

feature 'Blocks > Show' do
  include NamedFactories

  scenario 'show an flms block as a skrollr animation' do
    image_layer_1a1
    capybara_sign_in user_1
    visit "/flms/blocks"
    click_link "show-block-#{ block_1a.id }"
    expect(page).to have_selector ".block\##{block_1a.name}"
    expect(page).to have_selector ".image-layer\##{image_layer_1a1.name}"
  end
end
