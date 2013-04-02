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
  end
end
