require 'spec_helper'

describe Flms::Layer do
  describe 'keyframes' do
    describe 'build_default_keyframes' do
      let(:layer) { Flms::Layer.new.build_default_keyframes }
      it 'creates valid associations' do
        expect(layer.start_state_keyframe.layer).to eql layer
        expect(layer.target_state_keyframe.layer).to eql layer
        expect(layer.end_state_keyframe.layer).to eql layer
      end

      it 'preserves the associations through save/reload' do
        layer.save!
        layer.reload
        expect(layer.start_state_keyframe.layer).to eql layer
        expect(layer.target_state_keyframe.layer).to eql layer
        expect(layer.end_state_keyframe.layer).to eql layer
      end
    end

    describe 'validations' do
      describe 'for keyframes' do
        it 'requires all keyframes to be properly associated' do
          expect { Flms::Layer.create! }.to raise_error ActiveRecord::RecordInvalid
        end

        it 'passes validation when we correctly associate keyframes' do
          layer = Flms::Layer.new.build_default_keyframes
          expect { layer.save! }.not_to raise_error
        end
      end
    end
  end

  describe 'scroll start and end' do
    let(:layer) { l = Flms::Layer.new.build_default_keyframes; l.start_state_keyframe.scroll_start = 1; l }

    describe 'scroll_start' do
      it 'returns scroll start of initial state' do
        expect(layer.scroll_start).to eql 1
      end
    end

    describe 'scroll_end' do
      it 'returns scroll start of initial state plus durations of target and end states' do
        expected_value = layer.start_state_keyframe.scroll_start +
                         layer.target_state_keyframe.scroll_duration +
                         layer.end_state_keyframe.scroll_duration
        expect(layer.scroll_end).to eql expected_value
      end
    end
  end
end
