require 'spec_helper'

feature 'Pages > Show' do
  include NamedFactories

  scenario 'shows the page for a standard html request' do
    page_1
    image_layer_1a1
    image_layer_1b1_inactive
    image_layer_1c1
    visit "/flms/pages/#{page_1.url}"
    expect(page.body).to have_content page_1.title
  end

end
