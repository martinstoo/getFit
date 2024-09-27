FactoryBot.define do
  factory :training do
    sequence(:title) { |n| "Training #{n}" }
    description { "This is a training description" }
    association :benutzer
  end
end