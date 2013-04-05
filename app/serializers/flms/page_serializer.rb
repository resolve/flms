module Flms
  class PageSerializer < ActiveModel::Serializer
    attributes :name, :description, :thumbnail
    has_many :active_blocks, key: :blocks, serializer: Flms::BlockSerializer

    def name
      object.title
    end

    def description
      ''
    end

    def thumbnail
      ''
    end
  end
end
