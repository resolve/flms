module Flms
  class Layer < ActiveRecord::Base
    attr_accessible :name, :type

    belongs_to :block
  end
end
