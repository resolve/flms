require_dependency "flms/application_controller"

module Flms
  class UsersController < ApplicationController
    before_filter :authenticate_user!
    layout 'flms/admin'

    def index
      @users = Flms::User.all
    end

    def new
      @user = Flms::User.new
    end

    def create
      @user = Flms::User.new params[:user]
      if @user.save
        redirect_to users_path, notice: 'User created.'
      else
        render action: "new"
      end
    end

    def destroy
      @user = Flms::User.find params[:id]
      @user.destroy
      redirect_to users_path
    end
  end
end
