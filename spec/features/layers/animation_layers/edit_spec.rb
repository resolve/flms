require 'spec_helper'

feature 'AnimationLayers > Edit', js: true do
  include NamedFactories

  scenario 'editing an existing animation layer' do
    animation_layer_1a1

    capybara_sign_in user_1
    visit "/flms/blocks/#{block_1a.id}/edit"

    # click on the 'edit' button.
    click_link "edit-layer-#{animation_layer_1a1.id}"

    fill_in 'Name', with: 'new-layer-name'
    select 'contain', from: 'animation_layer_image_display_mode'

    click_button 'Update Animation layer'

    # Expect to be back at the block edit page.
    expect(current_path).to eql "/flms/blocks/#{block_1a.id}/edit"

    # Check database updates.
    expect(Flms::Layer).to have(1).instances
    expect(Flms::Layer.first.name).to eql 'new-layer-name'
  end
end
