require 'spec_helper'

feature 'TextLayers > Delete', js: true do
  include NamedFactories

  scenario 'deleting a text layer' do
    text_layer_1a1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Click on the 'delete' button.
    page.execute_script 'window.confirm = function() { return true }'
    click_link "delete-layer-#{text_layer_1a1.id}"

    # Expect to be back at the block page.
    expect(current_path).to eql "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Expect that the layer is deleted.
    expect(Flms::Layer).to have(0).instances
  end
end

