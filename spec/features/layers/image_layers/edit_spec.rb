require 'spec_helper'

feature 'ImageLayers > Edit', js: true do
  include NamedFactories

  scenario 'editing an existing image layer' do
    image_layer_1a1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # click on the 'edit' button.
    find('.btn.edit').click

    fill_in 'Name', with: 'new layer name'
    click_button 'Update Image layer'

    # Expect to be back at the block page.
    expect(current_path).to eql "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Check database updates.
    expect(Flms::Layer).to have(1).instances
    expect(image_layer_1a1.reload.name).to eql 'new layer name'
  end
end
