require 'spec_helper'

describe Flms::AnimationLayersController do
  include NamedFactories

  describe 'new' do
    describe 'access control' do
      let(:request) { get :new, block_id: block_1a.id, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do
      it 'provides an animation layer with associated keyframes' do
        sign_in user
        get :new, block_id: block_1a.id, use_route: :flms
        expect(assigns(:layer).start_state_keyframe).not_to be_nil
        expect(assigns(:layer).target_state_keyframe).not_to be_nil
        expect(assigns(:layer).end_state_keyframe).not_to be_nil
      end
    end
  end

  describe 'create' do
    describe 'access control' do
      let(:request) do
        layer = attributes_for(:animation_layer).merge(start_state_keyframe_attributes: attributes_for(:start_state_keyframe),
                                                       target_state_keyframe_attributes: attributes_for(:target_state_keyframe),
                                                       end_state_keyframe_attributes: attributes_for(:end_state_keyframe))
        post :create, block_id: block_1a.id, animation_layer: layer, use_route: :flms
      end
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/blocks/#{block_1a.id}/edit" }
      let(:database_performed_check) { Flms::AnimationLayer.count == 1 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end
  end

end

