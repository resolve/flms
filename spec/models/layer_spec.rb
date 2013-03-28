require 'spec_helper'

describe Flms::Layer do
  describe 'keyframes' do
    describe 'build_default_keyframes' do
      it 'creates valid associations' do
        the_layer = Flms::Layer.new.build_default_keyframes
        expect(the_layer.start_state_keyframe.layer).to eql the_layer
        expect(the_layer.target_state_keyframe.layer).to eql the_layer
        expect(the_layer.end_state_keyframe.layer).to eql the_layer
      end

      it 'preserves the associations through save/reload' do
        the_layer = Flms::Layer.new.build_default_keyframes
        the_layer.save!
        the_layer.reload
        expect(the_layer.start_state_keyframe.layer).to eql the_layer
        expect(the_layer.target_state_keyframe.layer).to eql the_layer
        expect(the_layer.end_state_keyframe.layer).to eql the_layer
      end
    end

    describe 'validations' do
      describe 'for keyframes' do
        it 'requires all keyframes to be properly associated' do
          expect { Flms::Layer.create! }.to raise_error ActiveRecord::RecordInvalid
        end

        it 'passes validation when we correctly associate keyframes' do
          l = Flms::Layer.new.build_default_keyframes
          expect { l.save! }.not_to raise_error
        end
      end
    end

  end
end
