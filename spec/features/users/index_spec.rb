require 'spec_helper'

feature 'Users > Index' do
  test_helpers

  scenario 'lists all existing users' do
    user_1 ; user_2

    capybara_sign_in user_1
    visit '/flms/users'

    expect(page).to have_content(user_1.email)
    expect(page).to have_content(user_2.email)
  end

end
