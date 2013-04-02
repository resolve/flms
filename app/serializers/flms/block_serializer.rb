module Flms
  class BlockSerializer < ActiveModel::Serializer
    has_many :layers, polymorphic: true
  end
end
