require 'spec_helper'

feature 'ParagraphLayers > Edit', js: true do
  include NamedFactories

  scenario 'editing an existing paragraph layer' do
    paragraph_layer_1a1

    capybara_sign_in user_1
    visit "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # click on the 'edit' button.
    click_link "edit-layer-#{paragraph_layer_1a1.id}"

    fill_in 'Name', with: 'new-layer-name'
    fill_in 'Header', with: 'header text'
    fill_in 'Body', with: 'body text'
    fill_in 'Color', with: 'abcabc'

    click_button 'Update Paragraph layer'

    # Expect to be back at the block page.
    expect(current_path).to eql "/flms/pages/#{page_1.url}/blocks/#{block_1a.id}"

    # Check database updates.
    expect(Flms::Layer).to have(1).instances
    expect(Flms::Layer.first.name).to eql 'new-layer-name'
    expect(Flms::Layer.first.header).to eql 'header text'
    expect(Flms::Layer.first.body).to eql 'body text'
  end
end
