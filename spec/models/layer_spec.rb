require 'spec_helper'

describe Flms::Layer do
  describe 'keyframes' do
    describe 'build_default_keyframes' do
      it 'creates valid associations' do
        layer = Flms::Layer.new.build_default_keyframes
        expect(layer.start_state_keyframe.layer).to eql layer
        expect(layer.target_state_keyframe.layer).to eql layer
        expect(layer.end_state_keyframe.layer).to eql layer
      end

      it 'preserves the associations through save/reload' do
        layer = Flms::Layer.new.build_default_keyframes
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
end
