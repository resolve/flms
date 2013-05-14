class TitleForBlocks < ActiveRecord::Migration
  def change
    add_column :flms_blocks, :title, :string
  end
end
