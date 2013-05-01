require 'spec_helper'

feature 'Video Layers > Create' do
  include NamedFactories

  scenario 'creating a new video layer' do
    capybara_sign_in user_1
    visit "/flms/blocks/#{block_1a.id}/edit"
    click_link 'Add Video Layer'
    fill_in 'Name', with: 'my-new-layer'
    fill_in 'Embed code', with: '<iframe src="http://my.video.com"></iframe>'
    click_button 'Create Video layer'

    # Expect to be back at the block edit page.
    expect(current_path).to eql "/flms/blocks/#{block_1a.id}/edit"

    # Expect that the layer is created.
    expect(Flms::Layer).to have(1).instances
    expect(block_1a.reload).to have(1).layers
    layer = block_1a.layers.first
    expect(layer.class).to eql Flms::VideoLayer
    expect(layer.name).to eql 'my-new-layer'
    expect(layer.embed_code).to eql '<iframe src="http://my.video.com"></iframe>'
  end
end
