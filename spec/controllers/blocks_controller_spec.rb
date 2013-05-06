require 'spec_helper'

describe Flms::BlocksController do
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
      let(:request) { post :create, block: attributes_for(:block), use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/blocks" }
      let(:database_performed_check) { Flms::Block.count == 1 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'show' do
    describe 'access control' do
      let(:request) { get :show, id: block_1a.id, use_route: :flms }
      it_should_behave_like 'an action accessible to the world'
    end

    it 'renders without template when requested' do
      get :show, id: block_1a.id, format: :plain_html, use_route: :flms
      expect { response }.not_to render_template 'flms/public'
    end

  end

  describe 'edit' do
    describe 'access control' do
      let(:request) { get :edit, id: block_1a.id, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'update' do
    describe 'access control' do
      let(:request) { put :update, id: block_1a.id, block: attributes_for(:block, name: 'new-name'), use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/blocks" }
      let(:database_performed_check) { Flms::Block.count == 1 && block_1a.reload.name == 'new-name' }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'delete' do
    describe 'access control' do
      let(:request) { delete :destroy, id: block_1a.id, use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/blocks" }
      let(:database_performed_check) { Flms::Block.count == 0 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end
end

