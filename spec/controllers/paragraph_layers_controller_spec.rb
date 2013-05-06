require 'spec_helper'

describe Flms::ParagraphLayersController do
  include NamedFactories

  describe 'new' do
    describe 'access control' do
      let(:request) { get :new, block_id: block_1a.id, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do
      it 'provides a paragraph layer with associated keyframes' do
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
        layer = attributes_for(:paragraph_layer).merge(start_state_keyframe_attributes: attributes_for(:start_state_keyframe),
                                                       target_state_keyframe_attributes: attributes_for(:target_state_keyframe),
                                                       end_state_keyframe_attributes: attributes_for(:end_state_keyframe))
        post :create, block_id: block_1a.id, paragraph_layer: layer, use_route: :flms
      end
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/blocks/#{block_1a.id}/edit" }
      let(:database_performed_check) { Flms::ParagraphLayer.count == 1 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do
      it 'creates a paragraph layer' do
        sign_in user
        new_layer = attributes_for(:paragraph_layer).merge(start_state_keyframe_attributes: attributes_for(:start_state_keyframe),
                                                           target_state_keyframe_attributes: attributes_for(:target_state_keyframe),
                                                           end_state_keyframe_attributes: attributes_for(:end_state_keyframe))
        new_layer.merge! header: 'header text', body: 'body text'
        post :create, block_id: block_1a.id, paragraph_layer: new_layer, use_route: :flms
        result_layer = Flms::Layer.first
        expect(result_layer.header).to eql 'header text'
        expect(result_layer.body).to eql 'body text'
      end
    end

  end

end

