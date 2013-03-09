require 'spec_helper'

describe Flms::UsersController do
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
      let(:request) { post :create, user: attributes_for(:user), use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == 'http://test.host/flms/users' }
      let(:database_performed_check) { Flms::User.count == 2 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

  describe 'delete' do
    describe 'access control' do
      let(:request) { delete :destroy, id: user_2.id, use_route: :flms }
      let(:access_granted_check) { response.status == 302 && response.location == 'http://test.host/flms/users' }
      let(:database_performed_check) { Flms::User.find_by_id(user_2.id) == nil }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end
end
