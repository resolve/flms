require 'spec_helper'

feature 'TextLayers > Create' do
  include NamedFactories

  scenario 'creating a new text layer' do
    capybara_sign_in user_1
    visit "/flms/blocks/#{block_1a.id}/edit"
    click_link 'Add Text Layer'
    fill_in 'Name', with: 'my-new-layer'
    fill_in 'Text', with: 'layer text content'
    fill_in 'Font size', with: '0.5'
    fill_in 'Color', with: 'fff'
    click_button 'Create Text layer'

    # Expect to be back at the block edit page.
    expect(current_path).to eql "/flms/blocks/#{block_1a.id}/edit"

    # Expect that the layer is created.
    expect(Flms::Layer).to have(1).instances
    expect(block_1a.reload).to have(1).layers
    layer = block_1a.layers.first
    expect(layer.class).to eql Flms::TextLayer
    expect(layer.name).to eql 'my-new-layer'
    expect(layer.text).to eql 'layer text content'
    expect(layer.font_size).to eql 0.5
    expect(layer.color).to eql 'fff'
  end
end
