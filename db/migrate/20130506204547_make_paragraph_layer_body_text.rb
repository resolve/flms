class MakeParagraphLayerBodyText < ActiveRecord::Migration
  def up
    change_column :flms_layers, :body, :text, limit: nil
  end

  def down
    change_column :flms_layers, :body, :string
  end
end
