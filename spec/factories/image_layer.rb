FactoryGirl.define do
  factory :image_layer, class: Flms::ImageLayer do
    name { Faker::Lorem.word }
  end
end

