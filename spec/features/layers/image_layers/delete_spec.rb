require 'spec_helper'

feature 'ImageLayers > Delete', js: true do
  include NamedFactories

  scenario 'deleting an image layer' do
    image_layer_1a1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Click on the 'delete' button.
    page.execute_script 'window.confirm = function() { return true }'
    find('.icon-trash').click

    # Expect to be back at the block page.
    expect(current_path).to eql "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Expect that the layer is deleted.
    expect(Flms::Layer).to have(0).instances
  end
end

