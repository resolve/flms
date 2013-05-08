class AddAnimationAttributes < ActiveRecord::Migration
  def change
    add_column :flms_layers, :frame_rate, :integer
    add_column :flms_layers, :frame_count, :integer
    add_column :flms_layers, :image_width, :integer
    add_column :flms_layers, :image_height, :integer
  end
end
