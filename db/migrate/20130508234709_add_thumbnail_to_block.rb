class AddThumbnailToBlock < ActiveRecord::Migration
  def change
    add_column :flms_blocks, :thumbnail, :string
  end
end
