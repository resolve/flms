class AddActiveToFlmsLayers < ActiveRecord::Migration
  def change
    add_column :flms_layers, :active, :boolean, default: true
  end
end
