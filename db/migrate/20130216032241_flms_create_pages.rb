class FlmsCreatePages < ActiveRecord::Migration
  def change
    create_table :flms_pages do |t|
      t.string :title
      t.string :url

      t.timestamps
    end

    add_index :flms_pages, :url
  end
end
