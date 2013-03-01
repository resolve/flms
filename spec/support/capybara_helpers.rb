module CapybaraHelpers

  # Signs the given user in.
  def capybara_sign_in user=user
    visit "/flms/login?email=#{user.email}"
  end
end
