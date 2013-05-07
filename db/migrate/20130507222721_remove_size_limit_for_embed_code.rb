class RemoveSizeLimitForEmbedCode < ActiveRecord::Migration
  def change
    change_column :flms_layers, :embed_code, :text, limit: nil
  end
end
