module Flms
  class Page < ActiveRecord::Base
    attr_accessible :title, :url

    has_many :blocks_pages
    has_many :blocks, through: :blocks_pages

    def to_param
      url
    end
  end
end
