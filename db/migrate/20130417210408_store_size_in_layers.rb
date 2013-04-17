class StoreSizeInLayers < ActiveRecord::Migration
  def change
    add_column :flms_layers, :width, :float
    add_column :flms_layers, :height, :float
  end
end
