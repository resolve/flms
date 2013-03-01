require 'spec_helper'

feature 'Pages > Index', js: true do
  test_helpers

  scenario 'shows all pages' do
    page_1 = create :page
    capybara_sign_in user_1
    visit '/flms/pages'
    expect(page).to have_content page_1.title
  end
end


