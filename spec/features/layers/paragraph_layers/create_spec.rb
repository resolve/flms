require 'spec_helper'

feature 'TextLayers > Create' do
  include NamedFactories

  scenario 'creating a new paragraph layer' do
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"
    click_link 'Add Paragraph Layer'
    fill_in 'Name', with: 'my-new-layer'
    fill_in 'Header', with: 'header text'
    fill_in 'Body', with: 'body content'
    click_button 'Create Paragraph layer'

    # Expect to be back at the block page.
    expect(current_path).to eql "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Expect that the layer is created.
    expect(Flms::Layer).to have(1).instances
    expect(block_1a.reload).to have(1).layers
    layer = block_1a.layers.first
    expect(layer.class).to eql Flms::ParagraphLayer
    expect(layer.name).to eql 'my-new-layer'
    expect(layer.header).to eql 'header text'
    expect(layer.body).to eql 'body content'
  end
end
