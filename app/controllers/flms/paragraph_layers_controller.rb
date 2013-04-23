require_dependency "flms/application_controller"

module Flms
  class ParagraphLayersController < ApplicationController
    layout 'flms/admin'
    before_filter :authenticate_user!
    before_filter :load_page
    before_filter :load_block
    before_filter :load_layer, only: [ :edit, :update ]

    def new
      @layer = ParagraphLayer.new.build_default_keyframes
    end

    def edit
    end

    def create
      @layer = ParagraphLayer.new params[:paragraph_layer]
      @layer.block = @block
      if @layer.save
        redirect_to page_block_path(@page, @block), notice: 'Layer created'
      else
        render action: "new"
      end
    end

    def update
      if @layer.update_attributes(params[:paragraph_layer])
        redirect_to [@page, @block], notice: 'Layer updated'
      else
        render action: "edit"
      end
    end

    private

    def load_page
      @page = Page.find_by_url params[:page_id]
    end

    def load_block
      @block = Block.find params[:block_id]
    end

    def load_layer
      @layer = ParagraphLayer.find params[:id]
    end
  end
end

