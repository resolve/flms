require 'spec_helper'

feature 'Pages > Create' do
  include NamedFactories

  scenario 'allows to create a new page' do
    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/edit"
    fill_in 'Title', with: 'my new title'
    fill_in 'Url', with: 'my new url'
    click_button 'Update Page'
    expect(page_1.reload.title).to eql 'my new title'
    expect(page_1.url).to eql 'my new url'
  end
end


