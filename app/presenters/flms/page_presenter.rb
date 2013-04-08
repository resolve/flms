module Flms
  class PagePresenter

    def initialize(page)
      @page = page
    end

    def to_html
      output = ''
      @page.active_blocks.each { |block| output << Flms::BlockPresenter.new(block).to_html + '<br/>' }
      output
    end
  end
end
