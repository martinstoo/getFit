FactoryBot.define do
  factory :uebung do
    sequence(:title) { |n| "Uebung #{n}" }
    description { "This is an uebung description" }
    association :benutzer
  end
end