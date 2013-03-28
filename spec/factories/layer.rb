FactoryGirl.define do
  factory :layer, class: Flms::Layer do
    name { Faker::Lorem.word }

    factory :image_layer, class: Flms::ImageLayer do
      start_state_keyframe
      target_state_keyframe
      end_state_keyframe

    end
  end
end
