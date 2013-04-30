class AddEmbedCodeToLayers < ActiveRecord::Migration
  def change
    add_column :flms_layers, :embed_code, :string
  end
end
