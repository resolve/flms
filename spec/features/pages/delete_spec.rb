require 'spec_helper'

feature 'Pages > Delete' do
  test_helpers

  scenario 'allows to delete a new page', js: true do
    create :page
    capybara_sign_in user_1
    visit "/flms/pages"
    page.evaluate_script 'window.confirm = function() { return true; }'
    click_link 'delete'
    expect(Flms::Page).to have(0).instances
  end
end
