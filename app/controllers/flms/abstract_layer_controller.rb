require_dependency "flms/application_controller"

module Flms
  class AbstractLayerController < ApplicationController
    layout 'flms/admin'
    before_filter :authenticate_user!
    before_filter :load_block
    before_filter :load_layer, only: [:show, :edit, :update, :delete]

    # All layer controllers utilize the same edit action
    def edit
    end

  protected

    # Call from create action in derived controller to complete create action
    def do_create
      @layer.block = @block
      if @layer.save
        redirect_to edit_block_path(@block), notice: 'Layer created'
      else
        render action: "new"
      end
    end

    # Call with result of update_attributes call from update action in
    # derived controller
    def do_update status
      if status
        redirect_to edit_block_path(@block), notice: 'Layer updated'
      else
        render action: "edit"
      end
    end

    def load_block
      @block = Block.find params[:block_id]
    end

    def load_layer
      raise 'I should be overridden in a derived class to load the proper layer type!'
    end
  end
end

