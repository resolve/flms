class CreateFlmsBlocks < ActiveRecord::Migration
  def change
    create_table :flms_blocks do |t|
      t.string :name

      t.timestamps
    end
  end
end
