class RemoveOrderingFromLayers < ActiveRecord::Migration
  def change
    remove_column :flms_layers, :ordering
  end
end
