FactoryGirl.define do
  factory :page, class: Flms::Page do
    title { Faker::Lorem.sentence }
    url { Faker::Lorem.word }
  end
end
