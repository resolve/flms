class CreateFlmsLayers < ActiveRecord::Migration
  def change
    create_table :flms_layers do |t|
      t.string :name
      t.integer :block_id
      t.integer :ordering

      t.timestamps
    end
    add_index :flms_layers, :block_id
  end
end
