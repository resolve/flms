require 'spec_helper'

feature 'Users > Create' do
  test_helpers

  scenario 'creates new users' do
    capybara_sign_in user_1
    visit '/flms/users/new'

    expect(page).to have_content('New User')

    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '12345678'
    click_button 'Create User'
    expect(Flms::User).to have(2).instances
    foo_user = Flms::User.find_by_email 'foo@bar.com'
    expect(foo_user).to_not be_nil
    expect(foo_user.email).to eql 'foo@bar.com'
  end
end
