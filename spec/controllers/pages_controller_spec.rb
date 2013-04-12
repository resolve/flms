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
end
