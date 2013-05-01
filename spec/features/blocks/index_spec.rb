require 'spec_helper'

feature 'Blocks > Index' do
  include NamedFactories

  scenario 'shows all blocks' do
    block_1 = create :block, name: 'block-1'
    block_2 = create :block, name: 'block-2'
    capybara_sign_in user_1
    visit '/flms/blocks'
    expect(page).to have_content block_1.name
    expect(page).to have_content block_2.name
  end

end
