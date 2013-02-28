module Flms
  class SessionsController < Devise::SessionsController
    layout 'flms/admin_login'

    def new

      # Fast-track to login for faster integration tests.
      if Rails.env == 'test' && email = params.delete(:email)
        return sign_in_and_redirect :user, User.where(email: email).first
      end

      render 'new'
    end

  end
end
