class AddEasingFunctionToLayer < ActiveRecord::Migration
  def change
    add_column :flms_layers, :easing_function, :string, default: 'linear'
  end
end
