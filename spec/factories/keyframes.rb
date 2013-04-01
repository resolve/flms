FactoryGirl.define do
  factory :keyframe, class: Flms::Keyframe do
    factory :start_state_keyframe, class: Flms::StartStateKeyframe
    factory :target_state_keyframe, class: Flms::TargetStateKeyframe
    factory :end_state_keyframe, class: Flms::EndStateKeyframe
  end
end
