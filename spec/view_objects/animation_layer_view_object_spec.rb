require 'spec_helper'

describe Flms::AnimationLayerViewObject do
  let(:animation_layer) { create :animation_layer, frame_rate: 100, frame_count: 3 }
  let(:view_object) { Flms::AnimationLayerViewObject.new(animation_layer) }

  describe 'src' do
    it 'returns url of attached image' do
      expect(view_object.src).to eql '/uploads/flms/animation_layer/image/1/placeholder.png'
    end
  end

  describe 'frame_sprite_height' do
    before { animation_layer.stub(:image_height).and_return 30 }

    it 'correctly calculates sprite height given image height' do
      expect(view_object.frame_sprite_height).to eql 10
    end
  end

  describe 'frame_pixel_start' do
    it 'provides correct pixel offset for frame 0' do
      expect(view_object.frame_pixel_start(0, 2)).to eql 2
    end

    it 'provides correct pixel offset for frame 1' do
      expect(view_object.frame_pixel_start(1, 2)).to eql 102
    end
  end

  describe 'frame_pixel_end' do
    it 'provides correct pixel offset for frame 0' do
      expect(view_object.frame_pixel_end(0, 2)).to eql 101
    end

    it 'provides correct pixel offset for frame 1' do
      expect(view_object.frame_pixel_end(1, 2)).to eql 201
    end
  end

  describe 'frames_attributes' do
    let(:attributes) { view_object.frames_attributes(1) }
    before do
      animation_layer.stub(:image_width).and_return 5
      animation_layer.stub(:image_height).and_return 30
      animation_layer.stub_chain(:image, :url).and_return "www.test.url.com"
    end

    it 'sets the correct width and height for the div based on image size and frame count' do
      expect(attributes[:style]).to match "width: 5px"
      expect(attributes[:style]).to match "height: 10px"
    end

    it 'provides the URL for the background image' do
      expect(attributes[:style]).to match "background-image: url\\(www.test.url.com\\)"
    end

    it 'includes data points at frame boundaries' do
      expect(attributes).to have_key "data-1"
      expect(attributes).to have_key "data-100"
      expect(attributes).to have_key "data-101"
      expect(attributes).to have_key "data-200"
      expect(attributes).to have_key "data-201"
      expect(attributes).to have_key "data-300"
    end

    it 'provides correct background positions for frames relative to image size' do
      expect(attributes['data-1']).to match "background-position: 0 0"
      expect(attributes['data-100']).to match "background-position: 0 0"
      expect(attributes['data-101']).to match "background-position: 0 -10"
      expect(attributes['data-200']).to match "background-position: 0 -10"
      expect(attributes['data-201']).to match "background-position: 0 -20"
      expect(attributes['data-300']).to match "background-position: 0 -20"
    end
  end

end
