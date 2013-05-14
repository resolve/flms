FactoryGirl.define do
  factory :block, class: Flms::Block do
    name { Faker::Lorem.word }
    title { Faker::Lorem.words(2).join(' ') }
  end
end
