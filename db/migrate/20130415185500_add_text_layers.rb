class AddTextLayers < ActiveRecord::Migration
  def change
    add_column :flms_layers, :text, :string
    add_column :flms_layers, :font_size, :float
    add_column :flms_layers, :color, :string
  end
end
