require 'spec_helper'

feature 'Blocks > Edit' do
  include NamedFactories

  scenario 'access edit page for a block' do
    block_1a
    capybara_sign_in user_1
    visit "/flms/blocks"
    click_link "edit-block-#{ block_1a.id }"
    expect(page).to have_content block_1a.name
  end

  scenario 'edit name of block' do
    block_1a
    capybara_sign_in user_1
    visit "/flms/blocks/#{block_1a.id}/edit"
    fill_in 'Name', with: 'new-block-name'
    click_button 'Update Block'
    expect(Flms::Block).to have(1).instances
    expect(block_1a.reload.name).to eql 'new-block-name'
  end

  scenario 'edit page shows list of layers' do
    block_1a
    layer_1a1
    capybara_sign_in user_1
    visit "/flms/blocks/#{block_1a.id}/edit"
    expect(page).to have_link "edit-layer-#{ layer_1a1.id }"
  end
end

