FactoryGirl.define do
  factory :keyframe, class: Flms::Keyframe do
    factory :start_state_keyframe, class: Flms::StartStateKeyframe
    factory :target_state_keyframe, class: Flms::TargetStateKeyframe
    factory :end_state_keyframe, class: Flms::EndStateKeyframe

    factory :test_keyframe do
      scroll_start      { 1 }
      scroll_duration   { 2 }
      width             { 0.3 }
      height            { 0.4 }
      position_x        { 0.5 }
      position_y        { 0.6 }
      opacity           { 0.7 }
      scale             { 0.8 }
      blur              { 0.9 }
    end
  end
end
