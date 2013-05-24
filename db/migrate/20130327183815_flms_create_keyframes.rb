class CreateFlmsKeyframes < ActiveRecord::Migration
  def change
    create_table :flms_keyframes do |t|
      t.timestamps
      t.integer   :layer_id, nil: false
      t.string    :type

      t.integer   :scroll_start
      t.integer   :scroll_duration

      t.float     :width
      t.float     :height
      t.float     :position_x
      t.float     :position_y
      t.float     :margin_left, default: 0, null: false
      t.float     :margin_top, default: 0, null: false

      t.float     :opacity
      t.float     :scale
      t.float     :blur

    end
  end
end
