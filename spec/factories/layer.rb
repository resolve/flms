FactoryGirl.define do
  factory :layer, class: Flms::Layer do
    name { Faker::Lorem.word }
  end
end
