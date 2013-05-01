require 'spec_helper'

feature 'VideoLayers > Edit', js: true do
  include NamedFactories

  scenario 'editing an existing video layer' do
    video_layer_1a1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # click on the 'edit' button.
    click_link "edit-layer-#{video_layer_1a1.id}"

    fill_in 'Name', with: 'new-layer-name'
    fill_in 'Embed code', with: 'a-new-embed-code'

    click_button 'Update Video layer'

    # Expect to be back at the block page.
    expect(current_path).to eql "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Check database updates.
    expect(Flms::Layer).to have(1).instances
    expect(Flms::Layer.first.name).to eql 'new-layer-name'
    expect(Flms::Layer.first.embed_code).to eql 'a-new-embed-code'
  end
end
