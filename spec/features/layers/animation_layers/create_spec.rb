require 'spec_helper'

feature 'AnimationLayer > Create' do
  include NamedFactories

  scenario 'creating a new 360 layer' do
    capybara_sign_in user_1
    visit "/flms/blocks/#{block_1a.id}/edit"
    click_link 'Add Animation Layer'
    fill_in 'Name', with: 'my-new-layer'
    fill_in 'Frame rate', with: '10'
    fill_in 'Frame count', with: '36'
    click_button 'Create Animation layer'

    # Expect to be back at the block edit page.
    expect(current_path).to eql "/flms/blocks/#{block_1a.id}/edit"

    # Expect that the layer is created.
    expect(Flms::Layer).to have(1).instances
    expect(block_1a.reload).to have(1).layers
    layer = block_1a.layers.first
    expect(layer.class).to eql Flms::AnimationLayer
    expect(layer.name).to eql 'my-new-layer'
    expect(layer.frame_rate).to eql 10
    expect(layer.frame_count).to eql 36
  end
end
