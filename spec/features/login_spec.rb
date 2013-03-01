require 'spec_helper'

feature 'log in' do
  test_helpers

  scenario 'with valid email and password' do
    visit '/flms/login'
    fill_in 'Email', with: user_1.email
    fill_in 'Password', with: user_1.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully.')
    #expect(page).to have_content('log out')
  end

  scenario 'with missing email' do
    visit '/flms/login'
    fill_in 'Password', with: user_1.password
    click_button 'Sign in'

    expect(page).to have_content 'Invalid email or password'
  end

  scenario 'with missing password' do
    visit '/flms/login'
    fill_in 'Email', with: user_1.email
    click_button 'Sign in'

    expect(page).to have_content 'Invalid email or password'
  end

  scenario 'with invalid email' do
    visit '/flms/login'
    fill_in 'Email', with: 'zonk@zonk.com'
    fill_in 'Password', with: user_1.password
    click_button 'Sign in'

    expect(page).to have_content 'Invalid email or password'
  end

  scenario 'with invalid password' do
    visit '/flms/login'
    fill_in 'Email', with: user_1.email
    fill_in 'Password', with: 'zonk'
    click_button 'Sign in'

    expect(page).to have_content 'Invalid email or password'
  end
end

