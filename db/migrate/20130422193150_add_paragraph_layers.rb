class AddParagraphLayers < ActiveRecord::Migration
  def change
    add_column :flms_layers, :header, :string
    add_column :flms_layers, :body, :string
  end
end
