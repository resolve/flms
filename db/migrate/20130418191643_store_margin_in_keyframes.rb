class StoreMarginInKeyframes < ActiveRecord::Migration
  def change
    add_column :flms_keyframes, :margin_left, :float, default: 0, nil: false
    add_column :flms_keyframes, :margin_top, :float, default: 0, nil: false
  end
end
