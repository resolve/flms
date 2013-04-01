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
    fill_in 'image_layer_start_state_keyframe_attributes_scroll_start', with: 1
    fill_in 'image_layer_start_state_keyframe_attributes_scroll_duration', with: '2'
    fill_in 'image_layer_start_state_keyframe_attributes_opacity_percent', with: '50'
    fill_in 'image_layer_start_state_keyframe_attributes_scale_percent', with: '25'
    fill_in 'image_layer_start_state_keyframe_attributes_blur_percent', with: '50'
    select 'top', from: 'image_layer_start_state_keyframe_attributes_position_name'
    fill_in 'image_layer_target_state_keyframe_attributes_scroll_duration', with: '3'
    fill_in 'image_layer_end_state_keyframe_attributes_scroll_duration', with: '4'
    fill_in 'image_layer_end_state_keyframe_attributes_opacity_percent', with: '60'
    fill_in 'image_layer_end_state_keyframe_attributes_scale_percent', with: '30'
    fill_in 'image_layer_end_state_keyframe_attributes_blur_percent', with: '60'
    select 'center', from: 'image_layer_end_state_keyframe_attributes_position_name'

    click_button 'Update Image layer'

    # Expect to be back at the block page.
    expect(current_path).to eql "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Check database updates.
    expect(Flms::Layer).to have(1).instances
  end
end
