require_dependency "flms/application_controller"

module Flms
  class UsersController < ApplicationController
    before_filter :authenticate_user!
    layout 'flms/admin'

    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new params[:user]
      if @user.save
        redirect_to users_path, notice: 'User created.'
      else
        render action: "new"
      end
    end

    def destroy
      @user = User.find params[:id]
      @user.destroy
      redirect_to users_path
    end
  end
end
