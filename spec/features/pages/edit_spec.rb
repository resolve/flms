require 'spec_helper'

feature 'Pages > Edit' do
  include NamedFactories

  scenario 'edit title and url for an existing page' do
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/edit"
    fill_in 'Title', with: 'my new title'
    fill_in 'Url', with: 'my new url'
    click_button 'Update Page'
    expect(page_1.reload.title).to eql 'my new title'
    expect(page_1.url).to eql 'my new url'
  end

  scenario 'click name of block to link to edit page for that block' do
    block_1a
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/edit"
    click_link block_1a.name
    expect(current_path).to eql "/flms/blocks/#{block_1a.id}/edit"
  end

  scenario 'click the button to remote a block from the page' do
    block_1a
    block_1c
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/edit"
    expect(page.find('.block_list')).to have_text block_1a.name
    expect(page.find('.block_list')).to have_text block_1c.name
    click_link "remove-block-#{block_1c.id}"
    expect(page.find('.block_list')).to have_text block_1a.name
    expect(page.find('.block_list')).not_to have_text block_1c.name
    expect(current_path).to eql "/flms/pages/#{page_1.url}/edit"
  end

  scenario 'link an existing block to this page' do
    block
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/edit"
    expect(page.find('.block_list')).not_to have_text block.name
    select block.name, from: 'block_id'
    click_button 'Add'
    expect(page.find('.block_list')).to have_text block.name
  end

  scenario 'activate a block', js: true do
    block_1a
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/edit"
    page.evaluate_script "$('.switch').bootstrapSwitch('setState', true);"
    click_on 'save'
    sleep 0.1
    expect(block_1a.reload.blocks_pages.first).to be_active
  end

  scenario 'drag blocks to rearrange them', js: true do
    block_1a
    block_1c
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/edit"
    page.evaluate_script "$.getScript('https://raw.github.com/mattheworiordan/jquery.simulate.drag-sortable.js/master/jquery.simulate.drag-sortable.js', function () { " \
      "$('[data-block-id=\"#{block_1a.id}\"]').simulateDragSortable({ move: 1 }); });"
    sleep 0.1
    click_on 'save'
    sleep 0.1
    expect(block_1c.reload.blocks_pages.first.ordering).to eql 0
    expect(block_1a.reload.blocks_pages.first.ordering).to eql 1
  end
end
