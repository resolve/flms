require 'spec_helper'

feature 'EmbedLayers > Edit', js: true do
  include NamedFactories

  scenario 'editing an existing embed layer' do
    embed_layer_1a1

    capybara_sign_in user_1
    visit "/flms/blocks/#{block_1a.id}/edit"

    # click on the 'edit' button.
    click_link "edit-layer-#{embed_layer_1a1.id}"

    fill_in 'Name', with: 'new-layer-name'
    fill_in 'Embed code', with: 'a-new-embed-code'

    click_button 'Update Embed layer'

    # Expect to be back at the block edit page.
    expect(current_path).to eql "/flms/blocks/#{block_1a.id}/edit"

    # Check database updates.
    expect(Flms::Layer).to have(1).instances
    expect(Flms::Layer.first.name).to eql 'new-layer-name'
    expect(Flms::Layer.first.embed_code).to eql 'a-new-embed-code'
  end
end
