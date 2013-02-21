module Flms
  class Page < ActiveRecord::Base
    attr_accessible :title, :url

    def to_param
      url
    end
  end
end
