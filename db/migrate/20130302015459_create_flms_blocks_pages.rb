class CreateFlmsBlocksPages < ActiveRecord::Migration
  def change
    create_table :flms_blocks_pages do |t|
      t.integer :block_id
      t.integer :page_id

      t.timestamps
    end
    add_index :flms_blocks_pages, :block_id
    add_index :flms_blocks_pages, :page_id
  end
end
