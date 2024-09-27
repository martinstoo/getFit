FactoryBot.define do
  factory :benutzer do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }

    trait :coach do
      role { 'coach' }
    end

    trait :student do
      role { 'student' }
    end
  end
end
  