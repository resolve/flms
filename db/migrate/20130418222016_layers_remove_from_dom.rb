class LayersRemoveFromDom < ActiveRecord::Migration
  def change
    add_column :flms_layers, :dom_remove, :boolean, default: true, nil: false
  end
end
