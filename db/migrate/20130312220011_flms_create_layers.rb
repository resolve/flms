class CreateFlmsLayers < ActiveRecord::Migration
  def change
    create_table :flms_layers do |t|
      t.string    :name
      t.string    :type
      t.integer   :block_id
      t.float     :width
      t.float     :height
      t.string    :z_index, default: '0', null: false
      t.string    :image_display_mode, default: 'cover'
      t.boolean   :dom_remove, default: true, null: false
      t.boolean   :active, default: true

      # Image layer attributes
      t.string    :image

      # Text layer attributes
      t.string    :text
      t.float     :font_size
      t.string    :color

      # Paragraph layer attributes
      t.string    :header
      t.text      :body, limit: nil

      # Embed layer attributes
      t.text      :embed_code, limit: nil

      # Animation layer attributes
      t.integer   :frame_rate
      t.integer   :frame_count
      t.integer   :image_width
      t.integer   :image_height

      t.timestamps
    end

    add_index :flms_layers, :block_id
  end
end
