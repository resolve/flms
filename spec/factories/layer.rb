# so we can use fixture_file_upload:
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :layer, class: Flms::Layer do
    name { Faker::Lorem.word }
    start_state_keyframe
    target_state_keyframe
    end_state_keyframe

    factory :image_layer, class: Flms::ImageLayer do
      image   { fixture_file_upload('spec/placeholder.png', 'image/png') }
    end

    factory :text_layer, class: Flms::TextLayer do
      text      { Faker::Lorem.sentence(4) }
      font_size 1.0
      color     'abc'
    end

    factory :paragraph_layer, class: Flms::ParagraphLayer do
      header    { Faker::Lorem.sentence(4) }
      body      { Faker::Lorem.sentence(10) }
    end

    factory :embed_layer, class: Flms::EmbedLayer do
      embed_code       { Faker::Internet.url }
    end

    factory :animation_layer, class: Flms::AnimationLayer do
      image       { fixture_file_upload('spec/placeholder.png', 'image/png') }
      frame_rate  10
      frame_count 2
      image_width 200
      image_height 100
    end
  end
end
