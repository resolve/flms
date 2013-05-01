require 'spec_helper'

describe Flms::TextLayersController do
  include NamedFactories

  describe 'new' do
    describe 'access control' do
      let(:request) { get :new, block_id: block_1a.id, use_route: :flms }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do
      it 'provides a text layer with associated keyframes' do
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
        layer = attributes_for(:text_layer).merge(start_state_keyframe_attributes: attributes_for(:start_state_keyframe),
                                                  target_state_keyframe_attributes: attributes_for(:target_state_keyframe),
                                                  end_state_keyframe_attributes: attributes_for(:end_state_keyframe))
        post :create, block_id: block_1a.id, text_layer: layer, use_route: :flms
      end
      let(:access_granted_check) { response.status == 302 && response.location == "http://test.host/flms/blocks/#{block_1a.id}/edit" }
      let(:database_performed_check) { Flms::TextLayer.count == 1 }
      it_should_behave_like 'an action accessible only to logged-in users'
    end

    describe 'functionality' do
      it 'creates a text layer' do
        sign_in user
        new_layer = attributes_for(:text_layer)
        new_layer.merge! start_state_keyframe_attributes: { scroll_start: 1,
                                                            scroll_duration: 2,
                                                            opacity_percent: 50,
                                                            scale_percent: 25,
                                                            blur_percent: 50,
                                                            position_name: 'top' },
                         target_state_keyframe_attributes: { scroll_duration: 3,
                                                             position_name: 'left' },
                         end_state_keyframe_attributes: { scroll_duration: 4,
                                                          opacity_percent: 60,
                                                          scale_percent: 30,
                                                          blur_percent: 60,
                                                          position_name: 'center' }
        post :create, block_id: block_1a.id, text_layer: new_layer, use_route: :flms
        result_layer = Flms::Layer.first
        expect(result_layer.start_state_keyframe.scroll_start).to eql 1
        expect(result_layer.start_state_keyframe.scroll_duration).to eql 2
        expect(result_layer.start_state_keyframe.opacity_percent).to eql 50
        expect(result_layer.start_state_keyframe.scale_percent).to eql 25
        expect(result_layer.start_state_keyframe.blur_percent).to eql 50
        expect(result_layer.start_state_keyframe.position_name).to eql 'top'
        expect(result_layer.target_state_keyframe.scroll_duration).to eql 3
        expect(result_layer.end_state_keyframe.scroll_duration).to eql 4
        expect(result_layer.end_state_keyframe.opacity_percent).to eql 60
        expect(result_layer.end_state_keyframe.scale_percent).to eql 30
        expect(result_layer.end_state_keyframe.blur_percent).to eql 60
        expect(result_layer.end_state_keyframe.position_name).to eql 'center'
      end
    end

  end

end

