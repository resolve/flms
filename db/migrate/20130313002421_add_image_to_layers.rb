class AddImageToLayers < ActiveRecord::Migration
  def change
    add_column :flms_layers, :image, :string
  end
end
