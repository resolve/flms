require 'spec_helper'

describe Flms::LayersController do
  include NamedFactories

  describe 'delete' do
    describe 'access control' do
      let(:request) { delete :destroy, id: block_1a.id, page_id: page_1.url, use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/pages/#{page_1.url}/blocks" }
      let(:database_performed_check) { Flms::Block.count == 0 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do

      it 'deletes the given image layer' do
        sign_in user
        delete :destroy, id: image_layer_1a1.id, block_id: block_1a.id, page_id: page_1.url, use_route: :flms

        expect(response).to redirect_to [page_1, block_1a]
        expect(Flms::Layer).to have(0).instances
      end
    end
  end
end

