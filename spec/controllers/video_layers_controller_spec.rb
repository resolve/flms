require 'spec_helper'

describe Flms::VideoLayersController do
  include NamedFactories

  describe 'new' do
    describe 'access control' do
      let(:request) { get :new, page_id: page_1.url, block_id: block_1a.id, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do
      it 'provides a video layer with associated keyframes' do
        sign_in user
        get :new, page_id: page_1.url, block_id: block_1a.id, use_route: :flms
        expect(assigns(:layer).start_state_keyframe).not_to be_nil
        expect(assigns(:layer).target_state_keyframe).not_to be_nil
        expect(assigns(:layer).end_state_keyframe).not_to be_nil
      end
    end
  end

  describe 'create' do
    describe 'access control' do
      let(:request) do
        layer = attributes_for(:video_layer).merge(start_state_keyframe_attributes: attributes_for(:start_state_keyframe),
                                                   target_state_keyframe_attributes: attributes_for(:target_state_keyframe),
                                                   end_state_keyframe_attributes: attributes_for(:end_state_keyframe))
        post :create, page_id: page_1.url, block_id: block_1a.id, video_layer: layer, use_route: :flms
      end
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/pages/#{page_1.url}/blocks/#{block_1a.id}" }
      let(:database_performed_check) { Flms::VideoLayer.count == 1 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do
      it 'creates a video layer' do
        sign_in user
        new_layer = attributes_for(:video_layer).merge(start_state_keyframe_attributes: attributes_for(:start_state_keyframe),
                                                       target_state_keyframe_attributes: attributes_for(:target_state_keyframe),
                                                       end_state_keyframe_attributes: attributes_for(:end_state_keyframe))
        new_layer.merge! embed_code: 'http://www.example.com'
        post :create, page_id: page_1.url, block_id: block_1a.id, video_layer: new_layer, use_route: :flms
        result_layer = Flms::Layer.first
        expect(result_layer.embed_code).to eql 'http://www.example.com'
      end
    end

  end

end

