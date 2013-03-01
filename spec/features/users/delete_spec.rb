require 'spec_helper'

feature 'Users > Delete' do
  test_helpers

  scenario 'allows to delete a new page', js: true do
    capybara_sign_in user_1
    visit "/flms/users"
    page.evaluate_script('window.confirm = function() { return true; }')
    click_link 'delete'
    expect(Flms::User).to have(0).instances
  end
end
