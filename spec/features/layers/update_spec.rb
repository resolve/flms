require 'spec_helper'

feature 'Layers > Update' do
  include NamedFactories

  scenario 'editing an existing layer' do
    layer_1a1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"
    click_link 'edit'
    fill_in 'Name', with: 'new layer name'
    click_button 'Update Layer'

    # Expect to be back at the block page.
    expect(current_path).to eql "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Check database updates.
    expect(Flms::Layer).to have(1).instances
    layer = block_1a.reload.layers.first
    expect(layer.name).to eql 'new layer name'
  end
end
