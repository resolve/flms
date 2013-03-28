FactoryGirl.define do
  factory :keyframe, class: Flms::Keyframe do

    factory :start_state_keyframe, class: Flms::StartStateKeyframe do

    end

    factory :target_state_keyframe, class: Flms::TargetStateKeyframe do

    end

    factory :end_state_keyframe, class: Flms::EndStateKeyframe do

    end
  end
end
