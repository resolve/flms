require 'spec_helper'

describe Flms::PagesController do
  include NamedFactories

  describe 'index' do
    describe 'access control' do
      let(:request) { get :index, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'new' do
    describe 'access control' do
      let(:request) { get :new, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'create' do
    describe 'access control' do
      let(:request) { post :create, page: attributes_for(:page), use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == 'http://test.host/flms/pages' }
      let(:database_performed_check) { Flms::Page.count == 1 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'show' do
    describe 'access control' do
      let(:request) { get :show, id: page_1.url, use_route: :flms }
      it_should_behave_like 'an action accessible to the world'
    end

    it 'raises a routing error if the page URL does not exist' do
      expect { get :show, id: 'a_url_that_does_not_exist', use_route: :flms }.to raise_error(ActionController::RoutingError)
    end

    it 'renders JSON when requested' do
      get :show, id: page_1.url, format: :json, use_route: :flms
      expect { JSON.parse(response.body) }.not_to raise_error
    end

    it 'renders without template when requested' do
      get :show, id: page_1.url, format: :plain_html, use_route: :flms
      expect { response }.not_to render_template 'flms/public'
    end
  end

  describe 'edit' do
    describe 'access control' do
      let(:request) { get :edit, id: page_1.url, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'update' do
    describe 'access control' do
      let(:request) { put :update, id: page_1.url, page: attributes_for(:page, title: 'new title', url: 'new-url'), use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == 'http://test.host/flms/pages' }
      let(:database_performed_check) { Flms::Page.count == 1 && page_1.reload.title == 'new title' }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'delete' do
    describe 'access control' do
      let(:request) { delete :destroy, id: page_1.url, use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == 'http://test.host/flms/pages' }
      let(:database_performed_check) { Flms::Page.count == 0 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'add block' do
    describe 'access control' do
      let(:request) { put :add_block, id: page_1.url, block: { id: block.id }, use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/pages/#{page_1.url}/edit" }
      let(:database_performed_check) { page_1.blocks.include?(block) }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'remove block' do
    describe 'access control' do
      let(:request) { delete :remove_block, id: page_1.url, block_id: block_1a.id, use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/pages/#{page_1.url}/edit" }
      let(:database_performed_check) { !page_1.reload.blocks.include?(block_1a) }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'update_all' do
    describe 'access control' do
      let(:request) { put :update_blocks, page_id: page_1.url, block_data: [], use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do
      it 'saves the given block status to the database' do
        page_1.blocks_pages.create block: block_1a, active: false
        page_1.blocks_pages.create block: block_1b_inactive, active: false
        sign_in user_1
        put :update_blocks,
            page_id: page_1.url,
            block_data: [{id: block_1a.id, active: false}, {id: block_1b_inactive.id, active: true}],
            use_route: :flms
        expect(page_1.position_for_block(block_1a.id).active).to be_false
        expect(page_1.position_for_block(block_1b_inactive.id).active).to be_true
      end

      it 'saves the given block order to the database' do
        page_1.blocks_pages.create block: block_1a, ordering: 0
        page_1.blocks_pages.create block: block_1b_inactive, ordering: 1
        sign_in user_1
        put :update_blocks,
            page_id: page_1.url,
            block_data: [ {id: block_1b_inactive.id, active: false}, {id: block_1a.id, active: false} ],
            use_route: :flms
        expect(page_1.position_for_block(block_1a.id).ordering).to eql 1
        expect(page_1.position_for_block(block_1b_inactive.id).ordering).to eql 0
      end
    end
  end
end
