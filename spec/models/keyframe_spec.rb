require 'spec_helper'

describe Flms::Keyframe do
  describe 'translation accessors' do
    describe 'opacity_percent' do
      it 'sets opacity correctly' do
        expect(Flms::Keyframe.new(opacity_percent: 50).opacity).to eql 0.5
      end

      it 'gets opacity correctly' do
        expect(Flms::Keyframe.new(opacity: 0.5).opacity_percent).to eql 50
      end
    end

    describe 'scale_percent' do
      it 'sets scale correctly' do
        expect(Flms::Keyframe.new(scale_percent: 50).scale).to eql 0.5
      end

      it 'gets scale correctly' do
        expect(Flms::Keyframe.new(scale: 0.5).scale_percent).to eql 50
      end
    end

    describe 'blur_percent' do
      it 'sets blur correctly' do
        expect(Flms::Keyframe.new(blur_percent: 50).blur).to eql 0.5
      end

      it 'gets blur correctly' do
        expect(Flms::Keyframe.new(blur: 0.5).blur_percent).to eql 50
      end
    end

    describe 'position_name' do
      it 'sets position coordinates from name correctly' do
        keyframe = Flms::Keyframe.new(position_name: 'top-right')
        expect(keyframe.position_x).to eql 1.0
        expect(keyframe.position_y).to eql 0.0
      end

      it 'gets position name from coordinates correctly' do
        keyframe = Flms::Keyframe.new(position_x: 1.0, position_y: 0.0)
        expect(keyframe.position_name).to eql 'top-right'
      end
    end
  end

  describe 'positions' do
    let(:keyframe) { Flms::Keyframe.new }

    describe 'position_name_valid?' do
      it 'returns true for all valid position names' do
        expect(keyframe.position_name_valid? 'center').to eql true
        expect(keyframe.position_name_valid? 'top-left').to eql true
        expect(keyframe.position_name_valid? 'top').to eql true
        expect(keyframe.position_name_valid? 'top-right').to eql true
        expect(keyframe.position_name_valid? 'right').to eql true
        expect(keyframe.position_name_valid? 'bottom-right').to eql true
        expect(keyframe.position_name_valid? 'bottom').to eql true
        expect(keyframe.position_name_valid? 'bottom-left').to eql true
        expect(keyframe.position_name_valid? 'left').to eql true
      end

      it 'returns false for a bad position name' do
        expect(keyframe.position_name_valid? 'an unknown position name').to eql false
      end
    end
    
    describe 'position_coordiates_valid?' do
      it 'returns true for all valid position coordinates' do
        expect(keyframe.position_coordinates_valid? [0.5, 0.5]).to eql true
        expect(keyframe.position_coordinates_valid? [0.0, 0.0]).to eql true
        expect(keyframe.position_coordinates_valid? [0.5, 0.0]).to eql true
        expect(keyframe.position_coordinates_valid? [1.0, 0.0]).to eql true
        expect(keyframe.position_coordinates_valid? [1.0, 0.5]).to eql true
        expect(keyframe.position_coordinates_valid? [1.0, 1.0]).to eql true
        expect(keyframe.position_coordinates_valid? [0.5, 1.0]).to eql true
        expect(keyframe.position_coordinates_valid? [0.0, 1.0]).to eql true
        expect(keyframe.position_coordinates_valid? [0.0, 0.5]).to eql true
      end
      
      it 'returns false for an unknown set of coordinates' do
        expect(keyframe.position_coordinates_valid? 'an unknown set of coordinates').to eql false
      end
    end

    describe 'position_name_to_coordinates' do
      it 'provides correct x,y coordinates for valid position names' do
        expect(keyframe.position_name_to_coordinates 'center').to eql [0.5, 0.5]
        expect(keyframe.position_name_to_coordinates 'top-left').to eql [0.0, 0.0]
        expect(keyframe.position_name_to_coordinates 'top').to eql [0.5, 0.0]
        expect(keyframe.position_name_to_coordinates 'top-right').to eql [1.0, 0.0]
        expect(keyframe.position_name_to_coordinates 'right').to eql [1.0, 0.5]
        expect(keyframe.position_name_to_coordinates 'bottom-right').to eql [1.0, 1.0]
        expect(keyframe.position_name_to_coordinates 'bottom').to eql [0.5, 1.0]
        expect(keyframe.position_name_to_coordinates 'bottom-left').to eql [0.0, 1.0]
        expect(keyframe.position_name_to_coordinates 'left').to eql [0.0, 0.5]
      end

      it 'raises an error when given an invalid position name' do
        expect { keyframe.position_name_to_coordinates 'an invalid position name' }.to raise_error
      end
    end

    describe 'position_coordinates_to_name' do
      it 'provides correct name from x,y coordinates' do
        expect(keyframe.position_coordinates_to_name [0.5, 0.5]).to eql 'center'
        expect(keyframe.position_coordinates_to_name [0.0, 0.0]).to eql 'top-left'
        expect(keyframe.position_coordinates_to_name [0.5, 0.0]).to eql 'top'
        expect(keyframe.position_coordinates_to_name [1.0, 0.0]).to eql 'top-right'
        expect(keyframe.position_coordinates_to_name [1.0, 0.5]).to eql 'right'
        expect(keyframe.position_coordinates_to_name [1.0, 1.0]).to eql 'bottom-right'
        expect(keyframe.position_coordinates_to_name [0.5, 1.0]).to eql 'bottom'
        expect(keyframe.position_coordinates_to_name [0.0, 1.0]).to eql 'bottom-left'
        expect(keyframe.position_coordinates_to_name [0.0, 0.5]).to eql 'left'
      end

      it 'raises an error when given coordinates that do not correspond to a known position' do
        expect { keyframe.position_coordinates_to_name [-1.0, -1.0] }.to raise_error
      end
    end
  end

end