require 'spec_helper'

describe Flms::BlocksController do
  test_helpers

  describe 'index' do
    describe 'access control' do
      let(:request) { get :index, page_id: page_1.url, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'new' do
    describe 'access control' do
      let(:request) { get :new, page_id: page_1.url, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'create' do
    describe 'access control' do
      let(:request) { post :create, page_id: page_1.url, block: attributes_for(:block), use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/pages/#{page_1.url}/blocks" }
      let(:database_performed_check) { Flms::Block.count == 1 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'show' do
    describe 'access control' do
      let(:request) { get :show, id: block_1.id, page_id: page_1.url, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'edit' do
    describe 'access control' do
      let(:request) { get :edit, id: block_1.id, page_id: page_1.url, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'update' do
    describe 'access control' do
      let(:request) { put :update, id: block_1.id, page_id: page_1.url, block: attributes_for(:block, name: 'new name'), use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/pages/#{page_1.url}/blocks" }
      let(:database_performed_check) { Flms::Block.count == 1 && block_1.reload.name == 'new name' }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'delete' do
    describe 'access control' do
      let(:request) { delete :destroy, id: block_1.id, page_id: page_1.url, use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/pages/#{page_1.url}/blocks" }
      let(:database_performed_check) { Flms::Block.count == 0 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end
end

