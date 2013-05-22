require 'spec_helper'

feature 'log out' do
  include NamedFactories

  scenario 'logged in user can log out via /flms/logout' do
    capybara_sign_in user_1
    visit '/flms/logout'
    expect(current_path).to eql "/"
  end
end

