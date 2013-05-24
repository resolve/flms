class FlmsCreateBlocks < ActiveRecord::Migration
  def change
    create_table :flms_blocks do |t|
      t.string :name
      t.string :title
      t.string :thumbnail

      t.timestamps
    end
  end
end
