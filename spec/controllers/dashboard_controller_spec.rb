require 'spec_helper'

describe Flms::DashboardController do
  test_helpers

  describe 'index' do
    describe 'access control' do
      let(:request) { get :index, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end
end
