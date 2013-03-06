module Flms
  class Block < ActiveRecord::Base
    attr_accessible :active, :name

    has_many :blocks_pages, class_name: 'Flms::BlocksPage', dependent: :destroy
    has_many :pages, through: :blocks_pages, class_name: 'Flms::Page'

    validates :name, presence: true
  end
end
