require 'spec_helper'

feature 'Blocks > Create' do
  include NamedFactories

  scenario 'creating a new block' do
    capybara_sign_in user_1
    visit "/flms/blocks"
    click_link 'New Block'
    fill_in 'Name', with: 'my-new-block'
    fill_in 'Title', with: 'Block Title'
    attach_file 'Thumbnail', 'spec/placeholder.png'

    click_button 'Create Block'

    expect(Flms::Block).to have(1).instances
    expect(Flms::Block.first.name).to eql 'my-new-block'
    expect(Flms::Block.first.title).to eql 'Block Title'
    expect(Flms::Block.first.thumbnail).not_to be nil
  end
end
