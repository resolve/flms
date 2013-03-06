FactoryGirl.define do
  factory :block, class: Flms::Block do
    name { Faker::Lorem.word }
    active false
  end
end
