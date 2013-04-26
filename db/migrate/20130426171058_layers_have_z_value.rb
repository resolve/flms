class LayersHaveZValue < ActiveRecord::Migration
  def change
    add_column :flms_layers, :z_index, :string, default: '0', null: false
  end
end
